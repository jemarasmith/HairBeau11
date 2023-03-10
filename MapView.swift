//
//  MapView.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import SwiftUI
import MapKit



struct MapView: UIViewRepresentable {
   
   // MARK: - NESTED TYPES
   
   class Coordinator: NSObject,
                      MKMapViewDelegate {
      
      // MARK: PROPERTIES
      
      var parent: MapView
      
      
      
      // MARK: INITIALIZER METHODS
      
      init(_ parent: MapView) { self.parent = parent }
      
      
      
      // MARK: METHODS
      
      func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
         
         print(mapView.centerCoordinate)
      }
      
      
      /// Customizes the way the annotation marker looks on the map :
      func mapView(_ mapView: MKMapView,
                   viewFor annotation: MKAnnotation)
      -> MKAnnotationView? {
         
          let view = MKMarkerAnnotationView(annotation: annotation,
                                         reuseIdentifier: nil)
          view.canShowCallout = true
         
          return view
      }
      /// `NOTE` ;
      ///  I want to briefly mention that `reuseIdentifier` property.
      ///  Creating views is expensive, which is why SwiftUI has things like the Identifiable protocol
      ///  – if it can identify its views uniquely then it can tell which ones have changed and which haven’t ,
      ///  which means it minimizes the amount of work it needs to do.
      ///  Frameworks such as `UIKit` and `MapKit` has a simpler version of the same concept ,
      ///  called _reuse identifiers_.
      ///  These are strings that can be anything we want ,
      ///  and allow the framework to keep a big array of views ready to be reused .
      ///  We can ask for one with a specific ID – “give me a pin with the identifier Placemark” –
      ///  and get one back from the array ready to be used , which means we don’t need to create it again.
      ///  We specified `nil` as the reuse identifier above, which means we don’t want to reuse views.
      ///  This is fine when you’re just learning – and realistically at any time when you’re only going to use a handful of pins –
      ///  but later on I’ll be showing you the more efficient route here , which means reusing views .
   }
   
   
   
   // MARK: - METHODS
   
   // typeAlias Context = UIViewRepresentableContext<Self>
   /// COMMAND+Click on Context to see its definition .
   func makeUIView(context: Context)
   -> some MKMapView {
      
      let mapView: MKMapView = MKMapView()
      /// ... 2️⃣ We can now connect that to our `MKMapView`:
      mapView.delegate = context.coordinator
      
      let annotation = MKPointAnnotation()
      annotation.title = "Virginia"
      annotation.subtitle = "Richmond"
      annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5407,
                                                     longitude: 77.4360)
      mapView.addAnnotation(annotation)
      
      return mapView
   }
   
   
   func updateUIView(_ uiView: UIViewType,
                     context: Context) {}
   
   
   func makeCoordinator()
   -> Coordinator {
      
      return Coordinator(self)
      ///  The `MapView` struct will send itself to the Coordinator
      ///  so it can report back what is happening ... 1️⃣
   }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
