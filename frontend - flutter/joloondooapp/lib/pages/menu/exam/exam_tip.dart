import 'package:flutter/material.dart';

class ExampTip extends StatelessWidget {
  const ExampTip({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Зөвлөгөө',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: const <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Замын хөдөлгөөний дүрмийн шалгалт нь 20 асуултаас бүрдэх бөгөөд нийт 20 минут үргэлжилнэ.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Шалгалт өгөх товчыг дарснаас хойш дэлгэцийн дээд буланд 20 минутыг тоолж хугацааг хэлж өгнө.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Хугацаа дуусах үед хэрэглэгч хариулж дууссан үгүйгээс үл харгалзан шалгалт шууд өндөрлөнө.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Нийт 20 асуултаас 18 буюу түүнээс дээш асуултанд зөв хариулсан тохиолдолд хэрэглэгч шалгалтанд тэнцсэн гэж дүгнэгдэнэ.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Хугацаа дуусаагүй үед хариултаа хэдэн ч удаа нягталж, засварлах боломжтой.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Хугацаа дуусахаас өмнө бүх асуултанд хариулсан бол шалгалтыг шууд өндөрлүүлэх боломжтой.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Шалгалтыг өндөрлүүлсэн нөхцөлд ямар асуултанд зөв, буруу хариулсныг харах боломжтой бөгөөд засварлах боломжгүй.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Шалгалтыг өндөрлүүлсэн үед тухайн асуултуудын тухай тайлбар гарч ирэх тул дахин алдах магадлалыг багасгана.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text(
                        'Шалгалтыг хэдэн ч удаа өгөх боломжтой тул дахин "Шалгалт өгөх" товчыг дарж, эхлүүлж болно.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right),
                    title: Text('Танд амжилт хүсье!!!'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: () {
                Navigator.pushNamed(context, '/exampage');
              },
              child: const Text(
                'Шалгалт өгөх',
                style: TextStyle(color: Color(0xFF1a2a5e), fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
