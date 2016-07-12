//
//  FoodListViewController.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class FoodListViewController: UITableViewController {

    private var  foods: [Food] = [Food]()
    
    
    func loadFoods() -> [Food]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Food.ArchiveURL.path!) as? [Food]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let savedFoods = loadFoods() {
            foods += savedFoods
        } else {
            loadDefaultFoods()
        }
        
       
    }

    func loadDefaultFoods(){
        foods.append(Food(name: "egg", photo: nil)!)
        foods.append(Food(name: "fish", photo: nil)!)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.foods.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foodCell", forIndexPath: indexPath) as! FoodCell
        
        


        cell.foodName.text = foods[indexPath.row].name
        
        cell.foodImage.image = foods[indexPath.row].photo
        
        return cell
    }
    
    
    @IBAction func exitToFoodList(segue: UIStoryboardSegue){
        
//        
//        if let preVC = segue.sourceViewController as? FoodViewController
//        {
//            self.foods.append(preVC.food!)
//            
//            saveFoods()
//            
//            self.tableView.reloadData()
//            
//        }
        
        if let preVC = segue.sourceViewController as? FoodViewController, food = preVC.food {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                foods[selectedIndexPath.row] = food
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: foods.count, inSection: 0)
                foods.append(food)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the meals.
            saveFoods()
        }

        
    }
    
    func saveFoods() {
        let success = NSKeyedArchiver.archiveRootObject(foods, toFile: Food.ArchiveURL.path!)
        if !success {
            print("Failed ...")
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            foods.removeAtIndex(indexPath.row)

            saveFoods()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showfood" {
            let foodViewController = segue.destinationViewController as! FoodViewController
            
            // Get the cell that generated this segue.
            if let selectedCell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedFood = foods[indexPath.row]
                foodViewController.food = selectedFood
            }
        }
        
    }
    

}
