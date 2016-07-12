//
//  FoodViewController.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

//class FoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
class FoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLSessionDelegate {
    
    var food: Food?
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var foodNameText: UITextField!
    

    
    
    @IBAction func loadFromNetwork(sender: AnyObject) {
        
        let imageURL = NSURL(string: "http://0574cake.com/images/201311/goods_img/43_P_1385801082107.JPG")!
        
        let request: NSURLRequest = NSURLRequest(URL: imageURL)

        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        
        
        defaultSession.dataTaskWithRequest(request).resume()
        
        
//        
//
//        let defaultConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
//        
//        defaultConnection!.start()
        
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        print("data coming...")
        dataRcvd.appendData(data)
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        print("data finished")
        self.photoImage.image = UIImage(data: dataRcvd)
    }
    

    var dataRcvd: NSMutableData = NSMutableData();
    
//    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
//        dataRcvd.appendData(data)
//    }
//    
//
//    func connectionDidFinishLoading(connection: NSURLConnection) {
//        self.photoImage.image = UIImage(data: dataRcvd)
//    }
    
    @IBAction func pickImage(sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self

        
        presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var photoImage: UIImageView!
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImage.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let food = food {
            navigationItem.title = food.name
            foodNameText.text   = food.name
            photoImage.image = food.photo
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelPressed(sender: AnyObject) {
        
        let isAddNew = self.presentingViewController is UINavigationController
        
        if isAddNew {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if saveBtn === sender {
            let name = foodNameText.text ?? ""
            
            let photo = photoImage.image
            
            food = Food(name: name, photo: photo )
        }
    }
    

}
