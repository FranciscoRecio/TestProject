//
//  FutureCell.swift
//  TestProject
//
//  Created by Admin on 2/25/18.
//  Copyright © 2018 Patel, Sanjay. All rights reserved.
//

import UIKit

class FutureCell: UICollectionViewCell {
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorSpecialty: UILabel!
 
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func setupCell(_ appointment: Appointment) {
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        
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
        
        doctorName.text = "Dr. \(appointment.providerLastName!)"
        doctorSpecialty.text = appointment.providerSpecialty!
        
        guard let date = appointment.dateAndTime else {return}
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "hh:mm a"
        timeLabel.text = dateFormatter.string(from: date)
        addressLabel.text = appointment.address!
    }
}
