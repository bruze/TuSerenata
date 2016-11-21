//
//  ChatVC.swift
//  TuSerenata
//
//  Created by Bruno Garelli on 9/20/16.
//  Copyright © 2016 Bruno Garelli. All rights reserved.
//

import JLChatViewController
import IQKeyboardManagerSwift

class ChatVC: JLChatViewController, ChatDataSource, ChatToolBarDelegate, JLChatMessagesMenuDelegate, ChatDelegate {
    /**
     Implement this method to load the correct message cell for the indexPath
     - parameter indexPath: The indexPath for the cell
     - returns: The loaded cell
     */
    public func jlChat(_ chat: JLChatTableView, MessageCellForRowAtIndexPath indexPath: IndexPath) -> JLChatMessageCell {
        let cell = JLChatMessageCell.init(style: .default, reuseIdentifier: "ChatCell")
        let message = mensajes[indexPath.row]
        if message.senderID != gerente.usuario?.key { // soy yo
            cell.textLabel?.textAlignment = .right
        }
        cell.textLabel?.text = message.text!
        return cell
    }

    /**
     This method will be called always when its necessary to get the corresponding message of indexPath
     - parameter indexPath: The position of JLMessage required
     */
    public func jlChatMessageAtIndexPath(_ indexPath: IndexPath) -> JLMessage? {
        return mensajes[indexPath.row]
    }

    var contestatario: Musico!
    var mensajes: [JLMessage] = []
    internal func cargarMensajes() {
        gerente.usuario!.refMensajes!.observe(.value, with: { (captura) in
            if captura.exists() {
                if captura.hasChild("nuevos") {
                    let nuevos = captura.childSnapshot(forPath: "nuevos")
                    print(self.chatTableView.myID)
                    for capturaIntermedia in nuevos.children {
                        let capturaMensajes = (capturaIntermedia as? FIRDataSnapshot)!
                        for capturaMensaje in capturaMensajes.children {
                            self.chatTableView.addNewMessages(1, changesHandler: {}, completionHandler: { self.chatTableView.reloadData(); self.chatTableView.reloadSections(NSIndexSet.init(indexesIn: NSRange.init()) as IndexSet, with: .automatic) })
                            self.chatTableView.addOldMessages(1, changesHandler: { 
                                
                            })
                            let nuevo = JLMessage.init(text: "HOLA", senderID: (gerente.usuario?.key)!, messageDate: Date.init(), senderImage: nil)
                            self.mensajes.append(nuevo)
                            let otro = JLMessage.desdeCaptura(capturaMensaje as! FIRDataSnapshot)
                            self.mensajes.append(otro)
                            //print(self.mensajes)
                            /*print(self.chatTableView.chatDataSource!)
                            print(self.chatTableView.chatDelegate)*/
                            //self.loadOlderMessages()
                        }
                        
                    }
                }
            }
        })
        /*if gerente.usuario!.refMensajes! {
            let mensajesSesion = gerente.usuario!.refMensajes!.child(contestatario.key)
            mensajesSesion.observeEventType(.Value, withBlock: { (captura) in
                if captura.exists() {
                    self.mensajes.append(JLMessage.desdeCaptura(captura))
                }
            })
        }
        if let nuevos = gerente.usuario?.mensajesNuevos {
            
        }*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBar.leftButton.isHidden = true
        toolBar.rightButton.isEnabled = true
        cargarMensajes()

        chatTableView.myID = gerente.usuario?.key
        chatTableView.chatDataSource = self
        chatTableView.chatDelegate = self
        chatTableView.messagesMenuDelegate = self
        configDefault()
    }
    func configDefault(){
        //2-start
        JLChatAppearence.configIncomingMessages(nil, showIncomingSenderImage: true, incomingTextColor: nil)
        
        JLChatAppearence.configOutgoingMessages(nil, showOutgoingSenderImage: true, outgoingTextColor: UIColor.e2eTomatoColor())
        //2-end
        
        JLChatAppearence.configErrorButton(nil, selectedStateImage: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    /**
     This method will be called always when its necessary to get the corresponding message of indexPath
     - parameter indexPath: The position of JLMessage required
     */
    
    /*func jlChatMessageAtIndexPath(_ indexPath:NSIndexPath)->JLMessage? {
        return mensajes[indexPath.row]
    }*/
    func jlChatKindOfHeaderViewInSection(_ section: Int) -> JLChatSectionHeaderViewKind {
        //you can change it to see the diference
        if  self.mensajes.count == 0{
            return JLChatSectionHeaderViewKind.customView
        }
        
        //return JLChatSectionHeaderViewKind.CustomDateView
        return JLChatSectionHeaderViewKind.defaultDateView
    }
    /**
     The number of messages in corresponding section
     - parameter section: The section that have the header views with date for example
     - returns: The number of messages of the corresponding section
     */
    func jlChatNumberOfMessagesInSection(_ section:Int)->Int {
        return mensajes.count
    }
    func numberOfDateAndCustomSectionsInJLChat(_ chat: JLChatTableView) -> Int {
        return mensajes.count
    }
    /**
     Implement this method to load the correct message cell for the indexPath
     - parameter indexPath: The indexPath for the cell
     - returns: The loaded cell
     */
    /*func jlChat(_ chat:JLChatTableView,MessageCellForRowAtIndexPath indexPath:NSIndexPath)->JLChatMessageCell {
        let cell = JLChatMessageCell.init(style: .Default, reuseIdentifier: "ChatCell")
        let message = mensajes[indexPath.row]
        if message.senderID != gerente.usuario?.key { // soy yo
            cell.textLabel?.textAlignment = .Right
        }
        cell.textLabel?.text = message.text!
        return cell
    }*/
    /**
     Executed when it is necessary to load older messages.
     */
    func loadOlderMessages() {
        let delayTime = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            
            self.chatTableView.reloadData()
            
        }
    }
    /**
     Executed when there is a tap on any message.
     */
    func didTapMessageAtIndexPath(_ indexPath:IndexPath) {
        
    }
    /**
     Called always when the user taps the left side button
     */
    func didTapLeftButton() {
        
    }
    /**
     * Called always when the user taps the right side button
     */
    func didTapRightButton() {
        
    }
    /**
     executed to discover if the UIMenuItem with title can be shown
     */
    func shouldShowMenuItemForCellAtIndexPath(_ title:String,indexPath:IndexPath)->Bool {
        return true
    }
    /**
     Define the title of the UIMenuItem that excutes the delete action.
     
     The default title is Delete.
     
     Return nil if you want to use the default title.
     */
    func titleForDeleteMenuItem() -> String? {
        return "Borrar"
    }
    /**
     Define the title of the UIMenuItem that excutes the send action.
     
     The default title is Try Again.
     
     Return nil if you want to use the default title.
     */
    func titleForSendMenuItem() -> String? {
        return "Enviar"
    }
    /**
     The action that delete message.
     */
    func performDeleteActionForCellAtIndexPath(_ indexPath:IndexPath) {
        
    }
    /**
     The action that tries to send again the message.
     */
    func performSendActionForCellAtIndexPath(_ indexPath:IndexPath) {
        
    }
}
