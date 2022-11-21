//
//  ViewController.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/18/22.
//

import UIKit

fileprivate let searchBarHeight : Int = 40

class ViewController: UIViewController {
    
    var tableView: UITableView?
    let network: NetworkManager
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
    var poke: [Sprite] = []
    var pageResults: [NameLink] = []
    var currentPage : PageResult?

    
    
    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        self.setUpUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUpUI()
        
        let path = "https://pokeapi.co/api/v2/pokemon"
        self.network.fetchPageResult(with: path) { page in
            guard let page = page else { return }
            //            self.pageResults = page.results
            self.pageResults.append(contentsOf: page.results)
            print(page)
            
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
            
            
        }
        
    }
    
//    private func requestNextPage(){
//           let pageUrl : URL?
//           if let currentPage = self.currentPage{
//               pageUrl = currentPage.next
//           }
//           else{
//               pageUrl = self.url
//           }
//           guard let pageUrl = pageUrl else {
//               return
//           }
//           self.network.fetchPageResult(with: pageUrl){
//               (resultPage : Result<PageResult, NetworkError>)  in
////                           print(resultPage?.results[3].url as Any)
////               guard let resultPage = resultPage else{
////                   print("failed to fetch pageresult \(pageUrl)")
////                   return
////               }
//               switch resultPage{
//               case .success(let page):
//                   self.currentPage = page
//                   self.pageResults.append(contentsOf: page.results)
//                   //
//                   DispatchQueue.main.async {
//                       self.tableView?.reloadData()
//                   }
//               case .failure(let error):
//                   print(error)
//               }
//           }
//       }

    
    
    private func setUpUI() {
        self.view.backgroundColor = .systemRed
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.dataSource = self
        // MARK: Row Select delegate
        table.delegate = self
        table.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        
        // add view to view hierarchy
        self.view.addSubview(table)
        
        
        
        table.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        table.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        self.tableView = table
        
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
        
        
        
        
        
//        placeholderVC.pokeImageView = UIImageView()
        
        placeholderVC.pokeNameLabel.text = "\(pageResults[indexPath.row].name)"
//        self.network.fetchRawData(with: pageResults[indexPath.row].url ?? "front_default") { image in
//        }
//        placeholderVC.pokeImageView.image = poke[indexPath.row].frontDefault
        self.navigationController?.pushViewController(placeholderVC, animated: true)
        


    }
}
//    

