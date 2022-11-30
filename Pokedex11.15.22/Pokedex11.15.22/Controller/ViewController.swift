//
//  ViewController.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import UIKit

//fileprivate let searchBarHeight : Int = 40

class ViewController: UIViewController {
    
    lazy var pokemonTableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.contentMode = .scaleAspectFit
        tableView.backgroundColor = .systemGray5
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.prefetchDataSource = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        return tableView
    }()
    
    var tableView: UITableView?
    let network: NetworkManager
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var poke: [Sprite] = []
    var pageResults: [NameLink] = []
    var currentPage : PageResult?
    var offset: Int = 0
    var limit: Int = 20
    
    
    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        self.setUpUI()
        self.requestNextPage()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUpUI()
        
        let path = "https://pokeapi.co/api/v2/pokemon"
        self.network.fetchPageResult(with: path) { page in
            
            switch page {
            case .success(let pr):
//                guard let page = page else { return }
//                            self.pageResults = page.results
                self.pageResults.append(contentsOf: pr.results)
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
//            guard let page = page else { return }
//                        self.pageResults = page.results
//            self.pageResults.append(contentsOf: page.results)
//            print(page)
//
//            DispatchQueue.main.async {
//                self.tableView?.reloadData()
//            }

        }
      self.requestNextPage()


    }
    
    private func requestNextPage(){
            let pageUrl : URL?
//            if let currentPage = self.currentPage{
//                pageUrl = currentPage.next
//            }
//            else{
                pageUrl = self.url
//            }
            guard let pageUrl = pageUrl else {
                return
            }
        print("page url is: \(pageUrl)")
        
        self.network.fetchPageResult(with: "\(pageUrl)?offset=\(offset)&limit=\(limit)"){
                (resultPage : Result<PageResult, NetworkError>) in

                switch resultPage{
                case .success(let pr):
//                    self.currentPage = page
                    self.pageResults.append(contentsOf: pr.results)
                    self.offset += self.limit
                    //
                    DispatchQueue.main.async {
                        self.pokemonTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }

    
    
    
    
    private func setUpUI() {
        self.view.backgroundColor = .systemRed
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.dataSource = self
        // MARK: Row Select delegate
        table.delegate = self
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")

        self.view.addSubview(table)
        
        table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
    }
    
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pageResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        //               cell.pokeNamelabel.text = pokemon[indexPath.row].name
        
        //        let basePath = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=30"
        
        print("cell for row")
        guard let url = self.pageResults[indexPath.row].url else {return UITableViewCell()}
        
        self.network.fetchPokemon(with:(url)) { data in
            
            guard let data = data else { return }
            let name = data.name
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                cell.pokeNamelabel.text = name
                
                
                let types = data.types
                cell.pokeTypeLabel.text = self.pokeTypesToString(type: types)
                guard let imageUrl = data.sprites.frontDefault else{return}
                self.network.fetchRawData(with: imageUrl) { image in
                    guard let image = image else {return}
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        cell.pokeImageView.image = UIImage(data: image)
                    }
                    
                }
                
            }
        }
        
        return cell
    }
    func pokeTypesToString(type: [Types]) -> String {
        var typesToString: String = ""
        type.forEach{elem in
            typesToString += "   \(elem.type.name)"
            
        }
        print("in poke type function")
        
        return typesToString
    }
    
}


//  MARK: Row Select funtion
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let placeholderVC = PokemonDetailVC()
           
        
        placeholderVC.pokeNameLabel.text = "\(pageResults[indexPath.row].name)"
        
        self.navigationController?.pushViewController(placeholderVC, animated: true)
        
        guard let url = self.pageResults[indexPath.row].url else { return }
        
        self.network.fetchPokemon(with:(url)) { data in
            
            guard let data = data else { return }
//            let name = data.name
            DispatchQueue.main.asyncAfter(deadline: .now()) {

                guard let imageUrl = data.sprites.frontDefault else{return}
                self.network.fetchRawData(with: imageUrl) { image in
                    guard let image = image else {return}
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        placeholderVC.pokeImageView.image = UIImage(data: image)
                    }
                    
                }
                
                
                
            }
        }
        
        return
    }
    
}



extension ViewController : UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastIndexPath = IndexPath(row: self.pageResults.count - 2, section: 0)
//        print(lastIndexPath)
        guard indexPaths.contains(lastIndexPath) else { return }
        self.requestNextPage()
    }
}
