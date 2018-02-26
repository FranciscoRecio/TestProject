//
//  PastCell.swift
//  TestProject
//
//  Created by Admin on 2/25/18.
//  Copyright © 2018 Patel, Sanjay. All rights reserved.
//

import UIKit

class PastCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    
    @IBOutlet weak var doctorImage: UIImageView!
    
    
    func setupCell(_ appointment: Appointment) {
        guard let date = appointment.dateAndTime else {return}
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "hh:mm a"
        appointmentLabel.text = dateFormatter.string(from: date) + " - Dr. " + appointment.providerLastName!
        
        specialtyLabel.text = appointment.providerSpecialty!
        
        Networking.getImage(appointment.providerId!) {
            [weak self] (image) in
            guard let image = image else {
                return
            }
            DispatchQueue.main.async {
                self?.doctorImage.image = image
            }
        }
        doctorImage.layer.cornerRadius = doctorImage.frame.height / 2
        doctorImage.layer.masksToBounds = true
    }
}
