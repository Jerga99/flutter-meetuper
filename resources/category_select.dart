// return FormField<Category>(
//   builder: (FormFieldState<Category> state) {
//     return InputDecorator(
//       decoration: InputDecoration(
//         icon: const Icon(Icons.color_lens),
//         labelText: 'Category',
//       ),
//       isEmpty: _meetupFormData.category == null,
//       child: new DropdownButtonHideUnderline(
//         child: new DropdownButton<Category>(
//           value: _meetupFormData.category,
//           isDense: true,
//           onChanged: (Category newCategory) {
//             // setState(() {
//             _meetupFormData.category = newCategory;
//             state.didChange(newCategory);
//             // });
//           },
//           items: _categories.map((Category category) {
//             return new DropdownMenuItem<Category>(
//               value: category,
//               child: new Text(category.name),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   },
// );
