//
//  DetailTableViewCell.swift
//  ProductDemo
//
//  Created by Alvin on 2021/1/30.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyRightLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    fileprivate var data: ProductModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initView()
    }
    
    private func initView() {
        
        self.selectionStyle = .none
        self.descriptionLabel.numberOfLines = 0
        self.copyRightLabel.numberOfLines = 0
        self.detailImageView.contentMode = .scaleToFill

    }
    
    
    func setValue(model: ProductModel) {
        
        self.data = model

        self.dateLabel.text = dateFomatterString(date: model.date)
        
        self.copyRightLabel.text = model.copyright
        self.descriptionLabel.text = model.description
        
        self.detailImageView.image = UIImage(named: "noimage")
        
        guard let url = URL(string: model.url) else {return}
        NetworkController.shared.fetchImage(url: url) { [weak self] (image) in
            guard let self = `self` else { return }
            DispatchQueue.main.async {
                if model.title == self.data?.title {
                    self.detailImageView.image = image
                }
            }
        }
    }
    
    
    private func dateFomatterString(date: String) -> String {
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd"
        let date = dateFomatter.date(from: date)
        
        let dateFormatterForString = DateFormatter()
        dateFormatterForString.dateFormat = "YYYY MMM. d"
        
        return(dateFormatterForString.string(from: date!))
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
