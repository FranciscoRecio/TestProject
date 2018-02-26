//
//  ViewController.swift
//  TestProject
//
//  Created by Patel, Sanjay on 3/31/17.
//  Copyright © 2017 Patel, Sanjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AppointmentServiceDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allTypes: UIButton!
    @IBOutlet weak var asthmaOnly: UIButton!
    
    //Local Data Models for past/future appointments
    var pastAppointments = [Appointment]()
    var futureAppointments = [Appointment]()
    var shownPastAppointments = [Appointment]()
    
    //Delegate function to retrieve and assign appointments
    func appointmentsRetrieved(pastAppointmentArray: [Appointment], futureAppointmentArray: [Appointment]) {
        self.pastAppointments = pastAppointmentArray
        self.futureAppointments = futureAppointmentArray
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Find Appointments using AppointmentService
        let service = AppointmentService.getInstance()
        service.delegate = self
        service.getAppointments()
        shownPastAppointments = pastAppointments
        // Display Appointments as per UI
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAll(_ sender: UIButton) {
        shownPastAppointments = pastAppointments
        allTypes.setTitleColor(UIColor.black, for: .normal)
        asthmaOnly.setTitleColor(UIColor(displayP3Red: 165/255, green: 165/255, blue: 165/255, alpha: 1), for: .normal)
        tableView.reloadData()
    }
    @IBAction func showAsthma(_ sender: UIButton) {
        shownPastAppointments = pastAppointments.filter{$0.isAsthmaAppointment!}
        asthmaOnly.setTitleColor(UIColor.black, for: .normal)
        allTypes.setTitleColor(UIColor(displayP3Red: 165/255, green: 165/255, blue: 165/255, alpha: 1), for: .normal)
        tableView.reloadData()
    }
    
}

private typealias CollectionViewSetup = ViewController
private typealias TableViewSetup = ViewController

//Provides number of items for Future Appointments
//and calls cell setup to set UI elements
extension CollectionViewSetup: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return futureAppointments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "futureCell", for: indexPath) as? FutureCell else {fatalError()}
        cell.setupCell(futureAppointments[indexPath.row])
        return cell
    }
}

//Handles sizing of Collection View Cells
extension CollectionViewSetup: UICollectionViewDelegateFlowLayout {
    //Sets size for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    //Resets cell size when orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        flowlayout.invalidateLayout()
    }
}

//Provides number of items for Past Appointments
//and calls cell setup to set UI elements
extension TableViewSetup: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownPastAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pastCell", for: indexPath) as? PastCell else {fatalError()}
        cell.setupCell(shownPastAppointments[indexPath.row])
        //Alternates color of each row
        if(indexPath.row % 2 == 1) {
            cell.backgroundColor = UIColor(displayP3Red: 235/255, green: 235/255, blue: 240/255, alpha: 1)
        }
        return cell
    }
}

//Sets height of table view rows
extension TableViewSetup: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
