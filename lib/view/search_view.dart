import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var maxItemCount = 100;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _searchTextController,
            onSubmitted: (value) {},
            decoration: InputDecoration(
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).iconTheme.color),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: 'Digite o nome da cidade'),
          ),
          Expanded(
            child: FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: maxItemCount,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('click - ' + index.toString());
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                            child: Column(
                              children: [
                                Text(
                                  'Cidade',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                Text(
                                  'Estado',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            ),
                          ),
                          const Divider(thickness: 2),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
