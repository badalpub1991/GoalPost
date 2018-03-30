# GoalPost

### Fetch , Update , Delete Data from CoreData

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
