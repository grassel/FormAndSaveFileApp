//
//  ViewController.swift
//  FormAndSaveFileApp
//
//  Created by Guido Grassel on 05/09/14.
//  Copyright (c) 2014 Guido Grassel. All rights reserved.
//

import UIKit

let theDocuemntsFolderForSavingFiles = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
let theFilename = "/theUswerFile2.txt";
let thePathToTheFile = theDocuemntsFolderForSavingFiles.stringByAppendingString(theFilename);


class ViewController: UIViewController {
                            
    @IBOutlet weak var theNameTextField: UITextField!
    @IBOutlet weak var theLastNameTextField: UITextField!
    @IBOutlet weak var theAgeField: UITextField!
    @IBOutlet weak var theLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func theSaveButtonMethod(sender: AnyObject) {
        var theName = theNameTextField.text;
        var theLastName = theLastNameTextField.text;
        var theAge = theAgeField.text;
        
        var theTxtFileString = "The user's info is \(theName), \(theLastName), \(theAge)";
        
        let theFileManager = NSFileManager.defaultManager();
        
        if (!theFileManager.fileExistsAtPath(thePathToTheFile)) {
            var theWriteError : NSError?
            var theFileToBeWritten = theTxtFileString.writeToFile(thePathToTheFile, atomically: true, encoding: NSUTF8StringEncoding, error: &theWriteError);
            
            if (theWriteError == nil) {
                println("No problem, we could save the file and the content was \(theTxtFileString)");
            } else {
                println("We encountered and error: \(theWriteError)");
            }
        } else {
            println("The file \(thePathToTheFile) exists already");
        }
        
        theNameTextField.resignFirstResponder();
        theLastNameTextField.resignFirstResponder();
        theAgeField.resignFirstResponder();
    }
    
    @IBAction func theLoadFileMethod(sender: AnyObject) {
        var theReadError : NSError?
        var theInfoFromFile : String!
        
        theInfoFromFile = String.stringWithContentsOfFile(thePathToTheFile, encoding: NSUTF8StringEncoding, error: &theReadError);
        
        if (theInfoFromFile != nil) {
            println("No problem, we could read from file and the content was \(theInfoFromFile)");
        } else {
            println("We encountered and error: \(theReadError)");
        }
        theLabel.text = theInfoFromFile;
    }
    
    @IBAction func theDeleteFileMethod(sender: AnyObject) {
        let theFileManager = NSFileManager.defaultManager();
        var theDeleteError : NSError?
        
        if (!theFileManager.fileExistsAtPath(thePathToTheFile)) {
             println("Nothing to delete, file \(thePathToTheFile) does not exist. Ignoring request");
            return;
        }
        
        if(theFileManager.removeItemAtPath(thePathToTheFile, error: &theDeleteError)) {
            println("No problem, we could delete file \(thePathToTheFile)");
        } else {
            println("Failed to delete file \(thePathToTheFile), error was \(theDeleteError)");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

