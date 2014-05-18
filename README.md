#NSDictionary+ImageMetadata

##Description##

**NSDictionary+ImageMetadata** and **NSDictionary-MetadataDatasource** are two categories for working with image metadata provided by the ImageIO framework.

The complete list of properties can be found in the [CGImageProperties reference] (https://developer.apple.com/library/mac/documentation/graphicsimaging/reference/CGImageProperties_Reference/Reference/reference.html)


**NSDictionary+ImageMetadata** provides a simple interface for searching and working with metadata  provided by ImageIO and AssetsLibrary frameworks.

**NSDictionary-MetadataDatasource** builds upon ImageMetadata methods and provides NSIndexPath based interface as well as a simple UITableViewDatasource implementation.

##Usage##

	// Local Image
	NSDictionary *metadata = [NSDictionary imageMetadataWithImageAtURL:self.imageURL];

**Note: you can pass in a remote URL but the call is synchronous and with no error handling so it’s not recommended.

or

	// ALAsset
	ALAssetRepresentation *myRep....
	NSDictionary *metadata = [myRep metadata];


To obtain a value for a CGImageProperty request the key from the dictionary.
	
	NSString *apetureValue=  [metadata sgg_valueForProperty:(id)kCGImagePropertyExifApertureValue];


NSDictionary-MetadataDatasource Example : 

	-(void)viewDidLoad
	{
		[super viewDidLoad];
		// keep a reference to the metadata since our tableview won’t retain it.
		self.metadata = [NSDictionary	imageMetadataWithImageAtURL:self.imageURL];
		self.tableView.dataSource = self.metadata;
	}
 
##License##
NSDictionary+ImageMetadata and NSDictionary-MetadataDatasource  is available under the MIT license. See the LICENSE file for more info.
