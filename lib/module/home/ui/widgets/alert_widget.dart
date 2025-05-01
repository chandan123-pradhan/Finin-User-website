import 'package:flutter/material.dart';
import 'package:naukri_user/common_widgets/bottom_widget.dart';
import 'package:naukri_user/utils/color_utils.dart';
import 'package:naukri_user/utils/size_utils.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
                                width: displayWeight(context) / 5.5,
                                // height: displayHeight(context) / 4,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey[350]!),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Get The Job in a minute",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Icon(Icons.info_outline, size: 16)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child:
                                        Container(
                                          height: displayHeight(context)/6,
                                          width: displayWeight(context)/4.2,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: 
                                            NetworkImage('https://cdn.nishtyainfotech.com/content/jobaaj/assets/img/post_blog/1679139858444.webp'),
                                            fit: BoxFit.fill
                                            )
                                          ),

                                        )
                                        
                                        ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: 
                                      
                                     BottomWidget.getMainBottom(
                                      
              color: ColorUtils.primaryBlue,
              context: context,
              title: 'Create Job alert',
              onPressed: () {},
            ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            
                            
  }
}