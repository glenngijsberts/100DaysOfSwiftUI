//
//  ContentView.swift
//  InstaFilter
//
//  Created by Glenn Gijsberts on 12/02/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    var keys: [String] {
        var filterKeys = [String]()
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            filterKeys.append("intensity")
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            filterKeys.append("radius")
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            filterKeys.append("scale")
        }
        
        return filterKeys
    }
    
    func save() {
        guard let processedImage = processedImage else { return }

        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage =  CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        print(currentFilter.inputKeys)
        
        applyProcessing()
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func applyProcessing() {
        if keys.contains("intensity") { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if keys.contains("radius") { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if keys.contains("scale") { currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a photo")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    image?.resizable().scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                if keys.contains("intensity") {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if keys.contains("radius") {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                if keys.contains("scale") {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale)
                            .onChange(of: filterScale) { _ in applyProcessing() }
                    }
                    .padding(.vertical)
                }
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet.toggle()
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(processedImage == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Group {
                    Button("Bloom") { setFilter(CIFilter.bloom()) }
                    Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
                    Button("Bokeh") { setFilter(CIFilter.bokehBlur()) }
                    Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                    Button("Edges") { setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                    Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                    Button("Vignette") { setFilter(CIFilter.vignette()) }
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
