//
//  ViewController.swift
//  listTestv1
//
//  Created by Elton Freitas on 15/03/22.
//

import UIKit

public var arrayDev : [String] = []
public var arrayDesigner : [String] = []

class ViewController: UIViewController {
    
    @IBOutlet weak var inserirNomeAlunoTextField: UITextField!
    @IBOutlet weak var tableViewDev: UITableView!
    @IBOutlet weak var listaDesigner: UITableView!
    
    public func juntarGrupos() -> [String]{
        var totalPessoas: [String] = []
        totalPessoas = arrayDev + arrayDesigner
        return totalPessoas
    }
    
    public func passarDev() -> [String]{
        let dev : [String] = arrayDev
        return dev
    }
    
    public func passarDesigner() -> [String]{
        let designer : [String] = arrayDesigner
        return designer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
        let salveData = UserDefaults.standard
        arrayDesigner = salveData.stringArray(forKey: "saveArray") ?? [String]()
        arrayDev = salveData.stringArray(forKey: "arrayDEV") ?? [String]()
        tableViewDev.delegate = self
        tableViewDev.dataSource = self
        listaDesigner.delegate = self
        listaDesigner.dataSource = self
        
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
    
    //inicio tela 1 botoes
    
    @IBAction func botaoDev(_ sender: Any) {
        guard let caixaTexto2 = inserirNomeAlunoTextField.text else
        {return}
        let caixaAux = caixaTexto2.trimmingCharacters(in: .whitespacesAndNewlines)
        if(caixaAux != ""){
            arrayDev.append(caixaAux)
            let salveData = UserDefaults.standard
            salveData.set(arrayDev, forKey: "arrayDEV")
            tableViewDev.reloadData()
        }
        inserirNomeAlunoTextField.text = ""
    }
    
    
    @IBAction func botaoDesigner(_ sender: Any) {
        guard let caixaTexto = inserirNomeAlunoTextField.text else
        {return}
        let caixaAux2 = caixaTexto.trimmingCharacters(in: .whitespacesAndNewlines)
        if(caixaAux2 != ""){
            arrayDesigner.append(caixaAux2)
            let salveData = UserDefaults.standard
            salveData.set(arrayDesigner, forKey: "saveArray")
            listaDesigner.reloadData()
        }
        inserirNomeAlunoTextField.text = ""
    }
    
    
} //fim bloco 1

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewDev {
            return arrayDev.count
        }
        else
        {
            return arrayDesigner.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewDev {
            let cell = tableViewDev.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = arrayDev[indexPath.row]
            return cell
        }
        else if tableView == listaDesigner
        {
            let cell = listaDesigner.dequeueReusableCell(withIdentifier: "listaDesigner", for: indexPath)
            cell.textLabel?.text = arrayDesigner[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == tableViewDev {
            if editingStyle == .delete {
                arrayDev.remove(at: indexPath.row)
                tableViewDev.deleteRows(at: [indexPath], with: .automatic)
            } else if editingStyle == .insert {
            }
        } else {
            arrayDesigner.remove(at: indexPath.row)
            listaDesigner.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
