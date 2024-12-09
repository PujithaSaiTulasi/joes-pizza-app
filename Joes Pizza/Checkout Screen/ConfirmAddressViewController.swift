import UIKit
import FirebaseFirestore
import FirebaseAuth
import MapKit
import CoreLocation

class ConfirmAddressViewController: UIViewController, CLLocationManagerDelegate {

    let db = Firestore.firestore()
    
    var mapView: MKMapView!
    var currentAddressLabel: UILabel!
    var aptTextField: UITextField!
    var locationTextField: UITextField!
    var homeWorkTextField: UITextField!
    var confirmButton: UIButton!
    var deliveryPickupStackView: UIStackView!
    var deliveryButton: UIButton!
    var pickupButton: UIButton!

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        setupUI()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func setupUI() {
        let stackViewContainer = UIView(frame: CGRect(x: 60, y: 100, width: self.view.frame.width - 100, height: 50))
        stackViewContainer.backgroundColor = .white
        stackViewContainer.layer.cornerRadius = 25
        stackViewContainer.layer.shadowColor = UIColor.black.cgColor
        stackViewContainer.layer.shadowOpacity = 0.2
        stackViewContainer.layer.shadowOffset = CGSize(width: 0, height: 4)
        stackViewContainer.layer.shadowRadius = 8

        deliveryPickupStackView = UIStackView(frame: stackViewContainer.bounds.insetBy(dx: 10, dy: 5))
        deliveryPickupStackView.axis = .horizontal
        deliveryPickupStackView.distribution = .fillEqually
        deliveryPickupStackView.spacing = 10

        deliveryButton = UIButton()
        deliveryButton.setTitle("Delivery", for: .normal)
        deliveryButton.setTitleColor(.white, for: .normal)
        deliveryButton.backgroundColor = .systemRed
        deliveryButton.layer.cornerRadius = 20
        deliveryButton.addTarget(self, action: #selector(deliveryButtonTapped), for: .touchUpInside)

        pickupButton = UIButton()
        pickupButton.setTitle("Pickup", for: .normal)
        pickupButton.setTitleColor(.white, for: .normal)
        pickupButton.backgroundColor = .lightGray
        pickupButton.layer.cornerRadius = 20
        pickupButton.addTarget(self, action: #selector(pickupButtonTapped), for: .touchUpInside)

        deliveryPickupStackView.addArrangedSubview(deliveryButton)
        deliveryPickupStackView.addArrangedSubview(pickupButton)
        stackViewContainer.addSubview(deliveryPickupStackView)
        self.view.addSubview(stackViewContainer)

        mapView = MKMapView(frame: CGRect(x: 0, y: 160, width: self.view.frame.width, height: 300))
        mapView.showsUserLocation = true
        self.view.addSubview(mapView)

        currentAddressLabel = UILabel(frame: CGRect(x: 20, y: 470, width: self.view.frame.width - 40, height: 40))
        currentAddressLabel.text = ""
        currentAddressLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(currentAddressLabel)

        let aptLabel = UILabel(frame: CGRect(x: 20, y: 540, width: self.view.frame.width - 40, height: 20))
        aptLabel.text = "Apt/Suite/Floor"
        aptLabel.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(aptLabel)

        aptTextField = UITextField(frame: CGRect(x: 20, y: 570, width: self.view.frame.width - 40, height: 40))
        aptTextField.placeholder = "Enter Apt/Suite/Floor"
        aptTextField.borderStyle = .roundedRect
        self.view.addSubview(aptTextField)

        let locationLabel = UILabel(frame: CGRect(x: 20, y: 630, width: self.view.frame.width - 40, height: 20))
        locationLabel.text = "Location"
        locationLabel.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(locationLabel)

        locationTextField = UITextField(frame: CGRect(x: 20, y: 660, width: self.view.frame.width - 40, height: 40))
        locationTextField.placeholder = "Enter Location (e.g., City, State)"
        locationTextField.borderStyle = .roundedRect
        locationTextField.addTarget(self, action: #selector(locationTextFieldChanged), for: .editingChanged)
        self.view.addSubview(locationTextField)

        let homeWorkLabel = UILabel(frame: CGRect(x: 20, y: 720, width: self.view.frame.width - 40, height: 20))
        homeWorkLabel.text = "Address Type (Home, Work, etc.)"
        homeWorkLabel.font = UIFont.systemFont(ofSize: 16)
        self.view.addSubview(homeWorkLabel)

        homeWorkTextField = UITextField(frame: CGRect(x: 20, y: 750, width: self.view.frame.width - 40, height: 40))
        homeWorkTextField.placeholder = "Enter Address Type"
        homeWorkTextField.borderStyle = .roundedRect
        self.view.addSubview(homeWorkTextField)

        confirmButton = UIButton(frame: CGRect(x: 20, y: self.view.frame.height - 80, width: self.view.frame.width - 40, height: 40))
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.backgroundColor = .systemRed
        confirmButton.layer.cornerRadius = 20
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        self.view.addSubview(confirmButton)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        let coordinate = currentLocation.coordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Your Location"
        mapView.addAnnotation(annotation)

        getAddressFromLocation(coordinate: coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }

    func getAddressFromLocation(coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error in geocoding: \(error)")
                return
            }
            if let placemark = placemarks?.first {
                var address = "\(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.postalCode ?? "")"

                self.currentAddressLabel.text = "\(address)"
            }
        }
    }

    @objc func confirmButtonTapped() {
        let apt = aptTextField.text ?? ""
        let location = locationTextField.text ?? ""
        let addressType = homeWorkTextField.text ?? ""
        
        if apt.isEmpty || location.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let address = "\(apt), \(location)"
        
        guard let userId = Auth.auth().currentUser?.email else {
            let alert = UIAlertController(title: "Error", message: "User not logged in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        db.collection("users").document(userId).getDocument { (documentSnapshot, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "Failed to fetch user data: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if let document = documentSnapshot, document.exists {
                if document.get("Address") != nil {
                    self.db.collection("users").document(userId).updateData([
                        "Address": address,
                        "AddressType": addressType
                    ]) { error in
                        if let error = error {
                            let alert = UIAlertController(title: "Error", message: "Failed to update address: \(error.localizedDescription)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Success", message: "Address updated successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    self.db.collection("users").document(userId).setData([
                        "Address": address,
                        "AddressType": addressType
                    ], merge: true) { error in
                        if let error = error {
                            let alert = UIAlertController(title: "Error", message: "Failed to save address: \(error.localizedDescription)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        } else {
                            let alert = UIAlertController(title: "Success", message: "Address saved successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }

    @objc func locationTextFieldChanged() {
        let location = locationTextField.text ?? ""
        if !location.isEmpty {
            geocodeAddress(address: location)
        }
    }

    func geocodeAddress(address: String) {
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print("Error in geocoding address: \(error)")
                return
            }
            if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate {
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                self.mapView.setRegion(region, animated: true)

                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = address
                self.mapView.addAnnotation(annotation)

                self.currentAddressLabel.text = "\(address)"
            }
        }
    }

    @objc func deliveryButtonTapped() {
        animateButtonSelection(selectedButton: deliveryButton, deselectedButton: pickupButton)
    }

    @objc func pickupButtonTapped() {
        animateButtonSelection(selectedButton: pickupButton, deselectedButton: deliveryButton)
    }

    private func animateButtonSelection(selectedButton: UIButton, deselectedButton: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            selectedButton.backgroundColor = .systemRed
            deselectedButton.backgroundColor = .lightGray
        })
    }
}
