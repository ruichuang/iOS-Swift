

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var app: App? {
        didSet {
            //navigationItem.title = app?.name
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id {
                let url = "http://www.statsallday.com/appstore/appdetail?id=\(id)"
                
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    do {
                        let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers ))
                        
                        let appDetail = App()
                        appDetail.setValuesForKeysWithDictionary(json as! [String: AnyObject])
                        
                        self.app = appDetail
                        
                        dispatch_sync(dispatch_get_main_queue(), { 
                            () -> Void in
                            self.collectionView?.reloadData()
                        })
                        
                        
                        
                    } catch let err {
                        print(err)
                    }
                    
                    
                }).resume()
            }
        }
    }
    private let headerId = "headerId"
    private let cellId = "cellId"
    private let descriptionCellId = "descroptionCellId"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView?.alwaysBounceVertical = true
        //print("set bg")
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        //print("register header")
        self.collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView?.registerClass(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView?.registerClass(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(descriptionCellId, forIndexPath: indexPath) as! AppDetailDescriptionCell
            cell.textView.attributedText = descriptionAttributedText()
            return cell
        }
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ScreenshotsCell
        cell.app = app
        
        return cell
    }
    
    private func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let range = NSMakeRange(0, attributedText.string.characters.count)
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = app?.desc {
            attributedText.appendAttributedString(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.darkGrayColor()]))
        }
        return attributedText
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            let sampleSize = CGSizeMake(view.frame.width - 8 - 8, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRectWithSize(sampleSize, options: options, context: nil)
            return CGSizeMake(view.frame.width, rect.height + 30)
        }
        
        return CGSizeMake(view.frame.width, 170)
    }
    
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        //print("dequeue")
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerId, forIndexPath: indexPath) as! AppDetailHeader
        header.app = app
        
        return header
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //print("set size")
        return CGSizeMake(view.frame.width, 205)
    }
}

class AppDetailDescriptionCell: BaseCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "$AMPLE"
        return tv
    }()
    
    let dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        return dv
    }()

    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerView)
        
        addConstranisWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstranisWithFormat("H:|-14-[v0]", views: dividerView)
        addConstranisWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerView)
        
    }
}



class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet{
            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
            }
            
            nameLabel.text = app?.name
            
            if let price = app?.price?.stringValue {
                buyButton.setTitle("$\(price)", forState: .Normal)
            }
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 30
        iv.layer.masksToBounds = true
        //print("imageview")
        return iv
    }()
    
    var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.lightGrayColor()
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "ssss"
        lbl.font = UIFont.systemFontOfSize(18)
        return lbl
    }()
    
    var buyButton: UIButton = {
        let btn = UIButton(type: .System)
        btn.setTitle("GET", forState: .Normal)
        btn.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        return btn
    }()
    
    var dividerView: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor(white: 0.2, alpha: 0.4)
        return dv
    }()
    
    override func setupViews() {
        
        super.setupViews()
        //print("set bg-blue")
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyButton)
        addSubview(dividerView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstranisWithFormat("H:|-14-[v0(140)]-8-[v1]|", views: imageView, nameLabel)
        addConstranisWithFormat("V:|-14-[v0(140)]", views: imageView)
        addConstranisWithFormat("V:|-14-[v0(22)]", views: nameLabel)
        
        addConstranisWithFormat("H:|-50-[v0]-50-|", views: segmentedControl)
        addConstranisWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstranisWithFormat("H:[v0(60)]-14-|", views: buyButton)
        addConstranisWithFormat("V:[v0(32)]-56-|", views: buyButton)
        
        addConstranisWithFormat("H:|[v0]|", views: dividerView)
        addConstranisWithFormat("V:[v0(0.5)]|", views: dividerView)
    }
    
}

extension UIView {
    func addConstranisWithFormat(format: String, views: UIView...){
        var viewsDictory = [String: UIView]()
        for (index, view) in views.enumerate() {
            let key = "v\(index)"
            viewsDictory[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictory))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //print("call setupViews")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //print("setup view called")
    }
}
