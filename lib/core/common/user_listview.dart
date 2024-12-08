import 'package:flutter/material.dart';
import 'package:stockvision_app/model/user.dart';

class UserListview extends StatelessWidget {
  const UserListview({super.key, required this.lsUser});
  final List<User> lsUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: lsUser.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text('${lsUser[index].fname} ${lsUser[index].email}'),
            subtitle: Text(
                lsUser[index].phonenumber.toString()), // Fix for phonenumber
            trailing: IconButton(
              onPressed: () {
                // Handle deletion here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete User'),
                    content: Text(
                        'Are you sure you want to delete ${lsUser[index].fname}?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // You can handle deletion logic here
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call a function to remove the user from the list
                          // Assuming the parent widget handles the state change
                          // You would need to pass a callback to handle deletion
                          Navigator.pop(context);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
