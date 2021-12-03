import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_playlist_app/src/models/generated_playlist.dart';
import 'package:magic_playlist_app/src/models/playlist.dart';
import 'package:magic_playlist_app/src/models/playlist_info.dart';
import 'package:magic_playlist_app/src/models/user.dart';
import 'package:magic_playlist_app/src/services/api_services.dart';
import 'package:magic_playlist_app/src/ui/pages/generated_playlist_screen.dart';
// import 'package:magic_playlist_app/src/ui/pages/generated_playlist_screen.dart';
import 'package:magic_playlist_app/src/ui/widgets/list_card.dart';
import 'package:magic_playlist_app/src/ui/widgets/playlist_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late Future<List<PlaylistInfo>> playlist;
  late Future<User> user;

  String playlistId = '';
  String playlistName = '';
  // int playlistSize = 0;

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = getUserInfo();
    playlist = getPlaylists();
  }

  @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

  void savePlaylist() async {
    GeneratedPlaylist generatedPlaylist= await generatePlaylist(playlistId, 20);
    String msg = await saveGeneratedPlaylist(textController.text, generatedPlaylist.ids);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: Column(
          children: [
          // Profile
            FutureBuilder<User> (
              future: user,
              builder: (BuildContext context, AsyncSnapshot snapshot) => 
                snapshot.hasData
                ? _profile(context, snapshot.data)
                : const Center(child: CircularProgressIndicator())
            ),
          // Playlists cards
          //----------------
            FutureBuilder<List<PlaylistInfo>> (
              future: playlist,
              builder: (BuildContext context, AsyncSnapshot snapshot) => 
                snapshot.hasData
                  ? PlaylistList(data: snapshot.data)
                  : const Center(child: CircularProgressIndicator())
            ),
        ],),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          // isScrollControlled: true,
          context: context, 
          builder: (context) => _sheetSelect(context),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // backgroundColor: Colors.transparent,
        ),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _profile(BuildContext context, User user) =>
    Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(user.image, width: 72, height: 72,)
          ),
          const SizedBox(width: 24,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenida/o', 
                style: GoogleFonts.comfortaa(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 28, 
                  fontWeight: FontWeight.w700
                ),
              ),
              Text(
                user.name, 
                style: GoogleFonts.comfortaa(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 18, 
                  fontWeight: FontWeight.w400
                )
              )
            ],
          )
      ],),
    );

  Widget _sheetSelect(BuildContext context) =>
    Container(
      padding: const EdgeInsets.all(16.0),
      // color: Theme.of(context).colorScheme.secondaryVariant,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Seleccione una playlist', 
            style: GoogleFonts.comfortaa(
              color: Theme.of(context).colorScheme.primaryVariant,
              fontSize: 18,
              fontWeight: FontWeight.w600
            )
          ),
          Container(
            height: 400,
            padding: const EdgeInsets.only(left: 24, right: 24),
            alignment: Alignment.topCenter,
            // margin: const EdgeInsets.only(top: 16),
            child: FutureBuilder<List<PlaylistInfo>>(
              future: playlist,
              builder: (BuildContext context, AsyncSnapshot<List<PlaylistInfo>> snapshot) => 
                snapshot.hasData 
                  // ? Text(snapshot.data!.length.toString())
                  ? ListView.builder(
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) =>
                      // Text(snapshot.data![index].name
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            playlistId = snapshot.data![index].id;
                          }),
                          // print(playlistId),
                          Navigator.of(context).pop(),
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context, 
                            builder: (context) => _sheetName(context, playlistId),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )
                            ),
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            // backgroundColor: Colors.transparent,
                          )
                        },
                        child: ListCard(
                          id: snapshot.data![index].id,
                          img: snapshot.data![index].image,
                          title: snapshot.data![index].name,
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator())
            ),
          )
        ],
      ),
    );

  Widget _sheetName(context, id) =>
    Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: Text('Playlist de referencia seleccionada', 
              style: GoogleFonts.comfortaa(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
            ),
          ),
          FutureBuilder <Playlist>(
            future: getPlaylistById(id),
            builder: (BuildContext context, AsyncSnapshot<Playlist> snapshot) =>
              snapshot.hasData
              ? Container(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        child: Image.network(snapshot.data!.info.image, width: 128, height: 128)
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 24),
                        child: Text(
                          snapshot.data!.info.name, 
                          style: GoogleFonts.comfortaa(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator())
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            width: MediaQuery.of(context).size.width - 48,
            height: 4,
            color: Theme.of(context).colorScheme.primary,
          ),
          TextField(
            style: GoogleFonts.comfortaa(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            controller: textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondaryVariant,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))
              ),
              labelText: 'Nombre de la playlist',
              labelStyle: GoogleFonts.comfortaa(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
            ),
          ),
          Container(
            // color: Theme.of(context).colorScheme.primary,
            margin: const EdgeInsets.only(top: 16, bottom: 24),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.of(context).pop(),
                // savePlaylist(),
                setState(() {
                  playlistName = textController.text;
                }),
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                    GeneratedPlaylistScreen(
                      referenceId: playlistId,
                      playlistName: playlistName,
                      playlistSize: 20
                    )
                  )
                ),
                textController.text = '',
              }, 
              child: Text('Generar', 
                style: GoogleFonts.poppins(
                // style: GoogleFonts.sourceCodePro(
                  color: Theme.of(context).colorScheme.background,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0
                )
              ),
            ),
          ),
        ]
      )
    );


}