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
                showToast("Success", message: "The file has been saved", buttonLabel: "Ok");
            } else {
                println("We encountered and error: \(theWriteError)");
                showToast("Error saving file", message: "Failed to write file", buttonLabel: "Ok");
            }
        } else {
            println("The file \(thePathToTheFile) exists already");
            showToast("Error saving file", message: "A file with the same name exists already", buttonLabel: "Ok");
        }
        
        theNameTextField.resignFirstResponder();
        theLastNameTextField.resignFirstResponder();
        theAgeField.resignFirstResponder();
    }
    
    @IBAction func theLoadFileMethod(sender: AnyObject) {
       
        let theFileManager = NSFileManager.defaultManager();
        var theInfoFromFile : String!
        var theReadError : NSError?
        
        theInfoFromFile = String.stringWithContentsOfFile(thePathToTheFile, encoding: NSUTF8StringEncoding, error: &theReadError);
        

        if (!theFileManager.fileExistsAtPath(thePathToTheFile)) {
            println("Nothing to read, file \(thePathToTheFile) does not exist. Ignoring request");
            showToast("Error", message: "Could not read the file, file does not exist.", buttonLabel: "Ok");
        }
        
        if (theInfoFromFile != nil) {
            println("No problem, we could read from file and the content was \(theInfoFromFile)");
        } else {
            println("We encountered and error: \(theReadError)");
            showToast("Error", message: "Could not read the file, though it exists.", buttonLabel: "Ok");
        }
        theLabel.text = theInfoFromFile;
    }
    
    @IBAction func theDeleteFileMethod(sender: AnyObject) {
        let theFileManager = NSFileManager.defaultManager();
        var theDeleteError : NSError?
        
        if (!theFileManager.fileExistsAtPath(thePathToTheFile)) {
             println("Nothing to delete, file \(thePathToTheFile) does not exist. Ignoring request");
            
            // show a toast informing the user
            self.showToast("Warning", message: "File does not exist, nothing to delete.", buttonLabel: "Ok");
                return;
        }
        
        if(theFileManager.removeItemAtPath(thePathToTheFile, error: &theDeleteError)) {
            println("No problem, we could delete file \(thePathToTheFile)");
            showToast("Success", message: "The file has been deleted", buttonLabel: "Ok");
        } else {
            println("Failed to delete file \(thePathToTheFile), error was \(theDeleteError)");
            showToast("Error", message: "Could not delete the file, though it exists.", buttonLabel: "Ok");
        }
    }
    
    func showToast(title:String, message:String, buttonLabel:String) {
        // show a toast informing the user
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: buttonLabel, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

