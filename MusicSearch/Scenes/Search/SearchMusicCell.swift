import UIKit

class SearchMusicCell: UITableViewCell {
    private lazy var albumArtworkImage: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private var task: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        buildViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViewHierarchy() {
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumArtworkImage)
    }
    
    private func setupConstraints() {
        albumArtworkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        albumArtworkImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        albumArtworkImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        albumArtworkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        
        trackNameLabel.topAnchor.constraint(equalTo: albumArtworkImage.topAnchor).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: albumArtworkImage.trailingAnchor, constant: 8).isActive = true
        trackNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: trackNameLabel.trailingAnchor).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: albumArtworkImage.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        task?.cancel()
        
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumArtworkImage.image = nil
    }
    
    func configure(with music: Music) {
        trackNameLabel.text = music.trackName
        artistNameLabel.text = music.artistName
        
        download(albumArtwork: music.artwork)
    }
    
    func download(albumArtwork: String) {
        guard let url = URL(string: albumArtwork) else {
            return
        }
        
        task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            guard let imgData = data else {
                return
            }
            
            DispatchQueue.main.async {
                self.albumArtworkImage.image = UIImage(data: imgData)
            }
        })
        
        task?.resume()
    }
}
