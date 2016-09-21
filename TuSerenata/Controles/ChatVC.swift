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
    override func viewDidLoad() {
        super.viewDidLoad()
        toolBar.leftButton.hidden = true
        //IQKeyboardManager.sharedManager().enable = false
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        //IQKeyboardManager.sharedManager().enable = true
    }
    /**
     This method will be called always when its necessary to get the corresponding message of indexPath
     - parameter indexPath: The position of JLMessage required
     */
    
    func jlChatMessageAtIndexPath(indexPath:NSIndexPath)->JLMessage? {
        return nil
    }
    /**
     The number of messages in corresponding section
     - parameter section: The section that have the header views with date for example
     - returns: The number of messages of the corresponding section
     */
    func jlChatNumberOfMessagesInSection(section:Int)->Int {
        return 0
    }
    
    /**
     Implement this method to load the correct message cell for the indexPath
     - parameter indexPath: The indexPath for the cell
     - returns: The loaded cell
     */
    func jlChat(chat:JLChatTableView,MessageCellForRowAtIndexPath indexPath:NSIndexPath)->JLChatMessageCell {
        return JLChatMessageCell.init(style: .Default, reuseIdentifier: "ChatCell")
    }
    /**
     Executed when it is necessary to load older messages.
     */
    func loadOlderMessages() {
        
    }
    /**
     Executed when there is a tap on any message.
     */
    func didTapMessageAtIndexPath(indexPath:NSIndexPath) {
        
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
    func shouldShowMenuItemForCellAtIndexPath(title:String,indexPath:NSIndexPath)->Bool {
        return false
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
    func performDeleteActionForCellAtIndexPath(indexPath:NSIndexPath) {
        
    }
    /**
     The action that tries to send again the message.
     */
    func performSendActionForCellAtIndexPath(indexPath:NSIndexPath) {
        
    }
}
