import 'package:flutter_blog_clean_arch_app/core/common/blocs/app/app_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/common/blocs/app_user/app_user_cubit.dart';
import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/connection_checker.dart';
import 'package:flutter_blog_clean_arch_app/core/network/internet_connection/iconnection_checker.dart';
import 'package:flutter_blog_clean_arch_app/features/auth/auth_inject.dart';
import 'package:flutter_blog_clean_arch_app/features/blog/blog_inject.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'injection.main.dart';
