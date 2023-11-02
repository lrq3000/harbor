
import 'package:flutter/material.dart';

import '../shared_ui.dart' as shared_ui;

class MonetizationStoreHelpPage extends StatelessWidget {

  const MonetizationStoreHelpPage({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: shared_ui.makeAppBarTitleText("Monetization"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text('How to Display Your Store Data', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Displaying your store data in our app is straightforward and can be done in three different ways:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Direct Store Link:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      'Connect your store directly using its URL. We currently support stores from Magento, Shopify, Spring, SquareSpace, Wix, and WooCommerce. Example: https://store.rossmanngroup.com/',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JSON File Link:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Provide a link to a JSON file hosted online, ensuring it follows our specified format. See the example below or click here for a live example.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '[{"Url": "https://example.com/product1", "Name": "Product 1", "Image": "https://example.com/image1.jpg"}, {"Url": "https://example.com/product2", "Name": "Product 2", "Image": "https://example.com/image2.jpg"}]',
                      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Direct JSON Input:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Directly paste your store data in JSON format into the provided text field. Ensure it adheres to the format shown in the JSON File Link option.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Choose the method that best suits your needs to seamlessly display your store data in the app.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      )
    );
  }
}
