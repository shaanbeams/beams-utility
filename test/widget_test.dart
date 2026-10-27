// @override
// Widget build(BuildContext context) {
//   return ListView.builder(
//     itemCount: chargeRows.length,
//     itemBuilder: (context, index) {
//       ChargeRow row = chargeRows[index];
//       return Row(
//         children: [
//           Expanded(child: Text(row.name)),
//           Expanded(
//             child: TextFormField(
//               initialValue: row.amount.toString(),
//               onChanged: (value) {
//                 chargeRows[index].amount = double.tryParse(value) ?? 0.0;
//               },
//               keyboardType: TextInputType.number,
//             ),
//           ),
//           Expanded(
//             child: TextFormField(
//               initialValue: row.amountReceived.toString(),
//               onChanged: (value) {
//                 chargeRows[index].amountReceived = double.tryParse(value) ?? 0.0;
//               },
//               keyboardType: TextInputType.number,
//             ),
//           ),
//           // Add other TextFormField widgets for the remaining columns similarly
//         ],
//       );
//     },
//   );
// }
