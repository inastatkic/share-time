// Created by Ina Statkic in 2021.
// Copyright © 2021 Ina. All rights reserved.

import Foundation

@MainActor
final class ActionManager: ObservableObject {
    
    @Published private(set) var actions: [Action] = []
    
    // An actor used to save and load the model data away from the main thread.
    private let fileValues = ActionActor()
    
    
    private func updateActions() async {
        await fileValues.save(actions)
    }
    
    public func addAction(title: String) {
        
        // Create a local array to hold the changes.
        var localActions = actions
        
        // Create a new drink and add it to the array.
        let action = Action(title: title)
        localActions.append(action)
        
        // Disappearing Actions
//        localActions.removeOutdatedActions()
        
        actions = localActions
    }
}

//extension Array where Element == Action {
//    fileprivate mutating func removeOutdatedActions() {
//
//    }
//}

private actor ActionActor {
    
    // MARK: - File Manager
    // Use this value to determine whether you have changes that can be saved to disk.
    private var savedValue: [Action] = []
    
    // Saving the actions data to disk.
    func save(_ actions: [Action]) {
        
        // Don't save the data if there haven't been any changes.
        if actions == savedValue {
            return
        }
        
        // Save as a binary plist file.
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        
        let data: Data
        
        do {
            // Encode the currentActions array.
            data = try encoder.encode(actions)
        } catch {
            return
        }
        
        do {
            // Write the data to disk
            try data.write(to: self.dataURL, options: [.atomic])
            
            // Update the saved value.
            self.savedValue = actions
        } catch {
            print("An error occurred while saving the data: \(error.localizedDescription)")
        }
    }
    
    // Loading the data from disk.
    func load() -> [Action] {
        
        let actions: [Action]
        
        do {
            // Load the drink data from a binary plist file.
            let data = try Data(contentsOf: self.dataURL)
            
            // Decode the data.
            let decoder = PropertyListDecoder()
            actions = try decoder.decode([Action].self, from: data)
        } catch CocoaError.fileReadNoSuchFile {
            print("No file found--creating an empty drink list.")
            actions = []
        } catch {
            fatalError("*** An unexpected error occurred while loading the drink list: \(error.localizedDescription) ***")
        }
        
        // Update the saved value.
        savedValue = actions
        return actions
    }

    // Returns the URL for the plist file that stores the drink data.
    private var dataURL: URL {
        get throws {
            try FileManager
                   .default
                   .url(for: .documentDirectory,
                        in: .userDomainMask,
                        appropriateFor: nil,
                        create: false)
                   // Append the file name to the directory.
                   .appendingPathComponent("Actions.plist")
        }
    }
}
