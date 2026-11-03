import 'package:flutter/material.dart';
void main()=>runApp(MARideApp());
class MARideApp extends StatelessWidget{
  @override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false, title:'MA+RIDE Nunukan', theme:ThemeData(primarySwatch:Colors.green), home:HomePage());
}
class HomePage extends StatefulWidget{ @override _HomePageState createState()=>_HomePageState(); }
class _HomePageState extends State<HomePage>{
  String sel='Bike'; String pay='Tunai'; int idx=0;
  final veh=[
    {'n':'Bike','i':Icons.motorcycle,'d':'Motor - Cepat di gang'},
    {'n':'Car','i':Icons.directions_car,'d':'Mobil - 4 orang'},
    {'n':'Pickup','i':Icons.local_shipping,'d':'Pickup - Angkut barang'},
    {'n':'SPEED BOAT','i':Icons.directions_boat,'d':'Nunukan-Sebatik-Tarakan'},
  ];
  @override Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:Text('MA+RIDE NUNUKAN'), backgroundColor:Color(0xFF00C853), centerTitle:true),
      body: idx==0?orderPage(): idx==1?Center(child:Text('Riwayat kosong')): profilePage(),
      bottomNavigationBar: BottomNavigationBar(currentIndex:idx, selectedItemColor:Color(0xFF00C853), onTap:(i)=>setState(()=>idx=i), items:[BottomNavigationBarItem(icon:Icon(Icons.home),label:'Beranda'), BottomNavigationBarItem(icon:Icon(Icons.receipt),label:'Riwayat'), BottomNavigationBarItem(icon:Icon(Icons.person),label:'Akun')]),
    );
  }
  Widget orderPage()=>SingleChildScrollView(padding:EdgeInsets.all(16), child:Column(crossAxisAlignment:CrossAxisAlignment.start, children:[
    Text('Mau kemana hari ini?', style:TextStyle(fontSize:22, fontWeight:FontWeight.bold)),
    SizedBox(height:12),
    TextField(decoration:InputDecoration(prefixIcon:Icon(Icons.my_location), hintText:'Jemput: Pasar Inpres Nunukan', border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))),
    SizedBox(height:12),
    TextField(decoration:InputDecoration(prefixIcon:Icon(Icons.location_on), hintText:'Tujuan: Pelabuhan Tunon Taka', border:OutlineInputBorder(borderRadius:BorderRadius.circular(12)))),
    SizedBox(height:20), Text('Pilih Kendaraan', style:TextStyle(fontSize:18, fontWeight:FontWeight.bold)), SizedBox(height:12),
    GridView.builder(shrinkWrap:true, physics:NeverScrollableScrollPhysics(), gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, childAspectRatio:1.6, crossAxisSpacing:12, mainAxisSpacing:12), itemCount:veh.length, itemBuilder:(c,i){var v=veh[i]; bool s=sel==v['n']; return GestureDetector(onTap:()=>setState(()=>sel=v['n'] as String), child:Container(decoration:BoxDecoration(color:s?Color(0xFF00C853).withOpacity(0.15):Colors.white, border:Border.all(color:s?Color(0xFF00C853):Colors.grey.shade300, width:s?2:1), borderRadius:BorderRadius.circular(16)), padding:EdgeInsets.all(12), child:Column(mainAxisAlignment:MainAxisAlignment.center, children:[Icon(v['i'] as IconData, size:32, color:s?Color(0xFF00C853):Colors.black87), SizedBox(height:6), Text(v['n'] as String, style:TextStyle(fontWeight:FontWeight.bold, fontSize:v['n']=='SPEED BOAT'?11:14)), Text(v['d'] as String, style:TextStyle(fontSize:9, color:Colors.grey), textAlign:TextAlign.center)])));}),
    SizedBox(height:20), Text('Metode Bayar', style:TextStyle(fontSize:18, fontWeight:FontWeight.bold)), SizedBox(height:8),
    Row(children:['Tunai','Saldo','QRIS'].map((m){bool s=pay==m; return Expanded(child:GestureDetector(onTap:()=>setState(()=>pay=m), child:Container(margin:EdgeInsets.only(right:8), padding:EdgeInsets.symmetric(vertical:12), decoration:BoxDecoration(color:s?Color(0xFF00C853):Colors.white, borderRadius:BorderRadius.circular(10), border:Border.all(color:Color(0xFF00C853))), child:Center(child:Text(m, style:TextStyle(color:s?Colors.white:Color(0xFF00C853), fontWeight:FontWeight.bold))))));}).toList()),
    if(pay=='QRIS') Container(width:double.infinity, margin:EdgeInsets.only(top:10), padding:EdgeInsets.all(12), decoration:BoxDecoration(color:Colors.grey.shade100, borderRadius:BorderRadius.circular(12)), child:Column(children:[Text('Scan QRIS MA+RIDE', style:TextStyle(fontWeight:FontWeight.bold)), SizedBox(height:8), Icon(Icons.qr_code_2, size:120), Text('Ganti dengan QRIS asli di assets', style:TextStyle(fontSize:10, color:Colors.grey))])),
    SizedBox(height:20),
    SizedBox(width:double.infinity, height:55, child:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFF00C853), shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(14))), onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Order $sel bayar $pay - MA+RIDE siap!')));}, child:Text('PESAN $sel SEKARANG', style:TextStyle(fontSize:16, fontWeight:FontWeight.bold, color:Colors.white)))),
  ]));
  Widget profilePage()=>ListView(padding:EdgeInsets.all(16), children:[Center(child:Column(children:[CircleAvatar(radius:40, backgroundColor:Color(0xFF00C853), child:Icon(Icons.person, size:40, color:Colors.white)), SizedBox(height:8), Text('Pengguna Nunukan', style:TextStyle(fontSize:18, fontWeight:FontWeight.bold)), Text('0812-xxxx-xxxx - Nunukan Kaltara')])), SizedBox(height:20), ListTile(leading:Icon(Icons.account_circle), title:Text('Akun Profil'), trailing:Icon(Icons.chevron_right)), ListTile(leading:Icon(Icons.wallet), title:Text('Saldo: Rp 0 - Topup via QRIS/Tunai')), ListTile(leading:Icon(Icons.help), title:Text('Bantuan WA Admin Nunukan')), ListTile(leading:Icon(Icons.logout), title:Text('Keluar'))]);
}
