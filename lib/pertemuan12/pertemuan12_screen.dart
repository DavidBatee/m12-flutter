import 'package:flutter/material.dart';
import 'package:flutter_application_12/pertemuan12/pertemuan12_detail.dart';
import 'package:flutter_application_12/pertemuan12/pertemuan12_provider.dart';
import 'package:provider/provider.dart';

class Pertemuan12Screen extends StatefulWidget {
  const Pertemuan12Screen({Key? key}) : super(key: key);

  @override
  State<Pertemuan12Screen> createState() => _Pertemuan12ScreenState();
}

class _Pertemuan12ScreenState extends State<Pertemuan12Screen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<Pertemuan12Provider>(context, listen: false).initialData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 12'),
      ),
      body: body(context),
    );
  }
  body(BuildContext context) {
    final prov = Provider.of<Pertemuan12Provider>(context);
    if(prov.data == null) {
      return const CircularProgressIndicator();
    }
    else {
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          prov.data['data']!.length,
          (index) {
            var item = prov.data['data']![index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Pertemuan12Detail(
                    cover: item['img'],
                    model: item['model'],
                    developer: item['developer'],
                    desc: item['desc'],
                    price: item['price'],
                    rating: item['rating'],
                  )));
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(item['img'])),
                      title: Text(item['model']),
                      subtitle: Text(
                        item['developer'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        item['desc'].toString().length >= 100 ? 
                        item['desc'].toString().substring(0, 100) + '...read more' :
                        item['desc'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rp. ${item['price'].toString()}, -',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Rating ${item['rating'].toString()}'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {}, icon: const Icon(Icons.thumb_up)
                        ),
                        IconButton(
                          onPressed: () {}, icon: const Icon(Icons.share)
                        )
                      ],
                    )
                  ],
                )
              ),
            );
          },
        ));
    }
  }
}