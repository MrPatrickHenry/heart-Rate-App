//
//  ContentView.swift
//  heart Rate App Watch App
//
//  Created by Patrick Henry on 10/6/23.
//

import SwiftUI
import HealthKit

class HeartRateFetcher {
    
    let healthStore = HKHealthStore()
    
    func fetchHeartRateData() {
        // Define the Predicate
        let startDate = Date().addingTimeInterval(-3600) // 1 hour ago
        let endDate = Date() // Now
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        
        // Define and Execute the Query
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            // Your completion code here
        }
        healthStore.execute(query)
    }
}

struct HeartRateView: View {
    
    var hrfetchController = HeartRateFetcher()
    
    var body: some View {
        Text("Heart Rate Data")
            .onAppear {
                hrfetchController.fetchHeartRateData()
            }
    }
}

struct HeartRateView_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateView()
    }
}
