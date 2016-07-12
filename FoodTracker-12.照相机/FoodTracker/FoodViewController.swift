//
//  FoodViewController.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var food: Food?
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var foodNameText: UITextField!
    

    
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
