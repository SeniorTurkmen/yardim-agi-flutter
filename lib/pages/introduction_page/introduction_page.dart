// ignore_for_file: avoid_escaping_inner_quotes

import 'package:afet_destek/gen/assets.gen.dart';
import 'package:afet_destek/pages/kvkk_page/kvkk_page.dart';
import 'package:afet_destek/shared/state/app_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  bool _isKVKKAccepted = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: height * 0.2),
                buildLogo(height),
                SizedBox(height: height * 0.05),
                buildTitle(context),
                SizedBox(height: height * 0.05),
                buildContent(context),
                SizedBox(height: height * 0.05),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: width * .8,
                  child: _KVKKCheckBox(
                    isAccepted: _isKVKKAccepted,
                    onAccepted: (value) {
                      setState(() {
                        _isKVKKAccepted = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: height * 0.01),
                SizedBox(
                  width: width * .8,
                  child: ElevatedButton(
                    onPressed: _isKVKKAccepted
                        ? () => context.read<AppCubit>().startApp()
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * .8, 50),
                      maximumSize: Size(width * .8, 70),
                    ),
                    child: const Text('Konum izni ver'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text buildContent(BuildContext context) {
    return Text(
      '''
      Bu platform lokasyon verinizi kullanarak çalışmaktadır.
      Lütfen cihazınızdaki konum servisini aktif ettiğinizden emin olunuz.
      ''',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      'Afet Destek Platformu',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  SvgPicture buildLogo(double height) {
    return SvgPicture.asset(
      Assets.logoSvg,
      height: height * .15,
    );
  }
}

class _KVKKCheckBox extends StatelessWidget {
  const _KVKKCheckBox({required this.isAccepted, required this.onAccepted});
  final bool isAccepted;
  final void Function(bool value) onAccepted;

  static bool _isOpenedOnce = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isAccepted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                onAccepted(value ?? false);
                if (!_isOpenedOnce) {
                  TermsPage.show(context, body: kvkkBody, title: kvkkTitle);
                  _isOpenedOnce = true;
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text.rich(
                textAlign: TextAlign.left,
                maxLines: 1000,
                TextSpan(
                  text: 'KVKK Açık Rıza Metni',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => TermsPage.show(
                          context,
                          body: kvkkBody,
                          title: kvkkTitle,
                        ),
                  children: const [
                    TextSpan(
                      text: "'ni okudum ve kabul ediyorum.",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String kvkkTitle = 'KVKK Açık Rıza Metni';
const String kvkkBody =
    '''Bu uygulama, 6 Şubat 2023 tarihinde Türkiye’de meydana gelen büyük deprem felaketinde, arama kurtarma çalışmaları ile yardım ve destek taleplerini ortak bir veri tabanında toplayarak yetkili kurum ve kuruluşlara aktarmak amacı ile bilişim teknolojileri alanında çalışan gönüllüler tarafından oluşturulmuştur. Yardım ya da desteğe ihtiyacı olduğunu belirttiğiniz kişilerin kişisel verileri ‘’Fiili imkânsızlık nedeniyle rızasını açıklayamayacak durumda bulunan veya rızasına hukuki geçerlilik tanınmayan kişinin kendisinin ya da bir başkasının hayatı veya beden bütünlüğünün korunması için zorunlu olması’’ hukuki sebebine dayanarak, otomatik yollarla işlenecektir. Tarafınıza ait kişisel veriler, ‘’Bir hakkın tesisi, kullanılması veya korunması için veri işlemenin zorunlu olması’’ hukuki sebebine dayanarak işlenecektir. Paylaşacağınız yardım, destek taleplerinde yer alan isim, soyisim, telefon ve adres gibi kişisel veriler, tarafımızca oluşturulan ve sunucuları yurtiçi ve yurtdışında bulunan veri tabanında toplanarak, Afad, Akut, Kızılay gibi yetkili arama kurtarma kuruluşlarının yanı sıra destek ve yardım taleplerini karşılayabilecek sivil toplum kuruluşları ile kişisel veri işleme amacı ile sınırlı olarak paylaşılacaktır.\n\nEnkaz, yıkım, yardım ve destek ihtiyaçları konusunda verdiğim bilgilerin doğru ve teyit edilmiş olduğunu, bilgi kirliliği ve yanlış uygulamalara yol açmamak için gerekli tüm önlem ve tedbirleri aldığımı, vermiş olduğum bilgilerde meydana gelen değişiklik ve güncellemeleri bildireceğimi kabul ve beyan ederim.''';
