
import UIKit

class parametersController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var listaResultado = [[String]]()
    let numeroDeOpcoes = ["2", "3", "5", "6", "10"]
    
    @IBOutlet weak var tabela: UITableView!
    var ajuda: String?
    var auxArray = [String]()
    let vC = ViewController()
    var contadorPessoas = 0
    var contadorGrupos = 1
    var aux = 0
    var aux2 = 2
    var contador: Int = 0
    var count = 1
    var qtdPessoas = 0
    var validacao: Bool = false
    
    
    @IBOutlet weak var numberSelector: UIPickerView!
    
    func sorteioComDesigner(){
        
        var dev : [String] = vC.passarDev()
        var designer : [String] = vC.passarDesigner()
        var grupo = [[String]]()
        dev.shuffle()
        designer.shuffle()
        
        for i in 0...dev.count - 1 {

            auxArray.append(dev[i])
            contadorPessoas += 1
            
            if contadorPessoas == 4 && aux <= 2{
                auxArray.append(designer[aux])
                grupo.append(auxArray)
                contadorPessoas = 0
                aux += 1
                auxArray.removeAll()
                contadorGrupos += 1;
                
            }else if contadorPessoas == 3 && aux2 <= 6{
                auxArray.append(designer[aux2])
                grupo.append(auxArray)
                contadorPessoas = 0
                aux2 += 1
                auxArray.removeAll()
                contadorGrupos += 1;
            }
        }
        aux = 0
        aux2 = 2
        contadorPessoas = 0
        contadorGrupos = 1
        
        listaResultado = grupo
        tabela.reloadData()
        
    }
    
    
    func sorteioSemDesigner(){
        
        var grupo = [[String]]()
        var totalPessoas : [String] = vC.juntarGrupos()
        totalPessoas.shuffle()
        
        switch qtdPessoas{
            
        case 2:
            
            for i in 0...totalPessoas.count - 1 {
                
                auxArray.append(totalPessoas[i])
                contador += 1
                
                if contador == qtdPessoas {
                    grupo.append(auxArray)
                    contador = 0
                    auxArray.removeAll()
                    count += 1
                }
                
                
            }
            
        case 3:
            
            for i in 0...totalPessoas.count - 1 {
                auxArray.append(totalPessoas[i])
                contador += 1
            
                if contador == qtdPessoas {
                    grupo.append(auxArray)
                    contador = 0
                    auxArray.removeAll()
                    count += 1
                }
            }
            
        case 5:
            
            for i in 0...totalPessoas.count - 1 {
                auxArray.append(totalPessoas[i])
                contador += 1
                if contador == qtdPessoas {
                    grupo.append(auxArray)
                    contador = 0
                    auxArray.removeAll()
                    count += 1
                }
            }
        case 6:
            
            for i in 0...totalPessoas.count - 1 {
                auxArray.append(totalPessoas[i])
                contador += 1
                
                if contador == qtdPessoas {
                    grupo.append(auxArray)
                    contador = 0
                    auxArray.removeAll()
                    count += 1
                }
            }
            
        case 10:
            
            for i in 0...totalPessoas.count - 1 {
                auxArray.append(totalPessoas[i])
                contador += 1
                
                if contador == qtdPessoas {
                    grupo.append(auxArray)
                    contador = 0
                    auxArray.removeAll()
                    count += 1
                }
            }
        default:
            print("Erro")
        }
        
        contador = 0
        count = 1
        listaResultado = grupo
        tabela.reloadData()
        
    }
    
        @IBOutlet weak var mySwitch: UISwitch!
        @IBAction func switchBotaoDesigner(_ sender: UISwitch) {
    
            if sender.isOn {
                validacao = true
                numberSelector.isHidden = true
                
            }else{
                validacao = false
                numberSelector.isHidden = false
                
            }
    
        }
    
    @IBAction func sortear(_ sender: Any) {
        guard let caixaTexto2 = ajuda else
        {return}
        
        if validacao == true{
            sorteioComDesigner()
        }else if validacao == false{
            qtdPessoas = Int(caixaTexto2) ?? 0
            sorteioSemDesigner()
        }else{
            print ("Erro")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabela.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = listaResultado[indexPath.section][indexPath.row]
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listaResultado.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaResultado[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Grupo \(section + 1)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabela.delegate = self
        tabela.dataSource = self
        tabela.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        numberSelector.delegate = self
        numberSelector.dataSource = self
        
        mySwitch.isOn = false
        
        ajuda = numeroDeOpcoes.first
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

// UIPicker

extension parametersController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numeroDeOpcoes.count
    }
}

extension parametersController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numeroDeOpcoes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ajuda = numeroDeOpcoes[row]
    }
}
