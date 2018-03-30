# GoalPost

#### XCData Model
![screen shot 2018-03-30 at 11 35 55 pm](https://user-images.githubusercontent.com/11573422/38154607-2bd613cc-3473-11e8-9d26-7bf21fcc44b6.png)


### Fetch , Update , Delete , Save Data from CoreData

     extension GoalsVc {
    //-------------------------  Update CoreData  ------------------------------------------------------//
    func setProgress(atIndexpath indexPath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
  
        let choosenGoal = arrGoal[indexPath.row]
        if choosenGoal.goalProgress < choosenGoal.goalComplitionValue {
            choosenGoal.goalProgress = choosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
             try managedContext.save()
        } catch {
            debugPrint("Could not set Progress: \(error.localizedDescription)")
        }
    }
    
    //-------------------------  fetch from CoreData   -------------------------------------//
    func fetch(completion: (_ complete:Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        do {
            arrGoal =   try managedContext.fetch(fetchRequest) 
            completion(true)
        } catch {
            debugPrint("Could not Fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    //---------------------------   Delete from CoreData   -----------------------------------//
    func removeGoal(atIndexPath indexpath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(arrGoal[indexpath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint("Object not deleted:\(error.localizedDescription)")
        }
    }
    }
    
        //---------------------------   Save in CoreData   -----------------------------------//
     func save(completion: (_ finished: Bool) -> ()) {
        guard let manageContex = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: manageContex)
        goal.goalDescription = goalDescription
        goal.goalType = type.rawValue
        goal.goalComplitionValue = Int32(txtPoints.text!)!
        goal.goalProgress = Int32(0)
        do {
         try  manageContex.save()
            completion(true)
        } catch {
            debugPrint("could not save \(error.localizedDescription)")
            completion(false)
        }
    }
