import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../shared/widgets/animated_glass_background.dart';
import '../../shared/widgets/glass_card.dart';
import '../../shared/widgets/gradient_button.dart';
import '../../shared/widgets/modern_back_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isLoading = false;
  UserRole selectedRole = UserRole.doctor;

  Future<void> signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final loc = AppLocalizations.of(context);

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc.translate('fillRequiredFields'))),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          content: Text(loc.translate('passwordsDoNotMatch')),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          content: Text(e.message ?? loc.translate('signupFailed')),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.error,
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const ModernBackButton(),
        title: Text(
          loc.translate('staffRegistration'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.primaryDark,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedGlassBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  children: [
                    // Official Logo Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadowBlue,
                            blurRadius: 20,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 54,
                        height: 54,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Glass Card Signup Form
                    GlassCard(
                      borderRadius: 28,
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.translate('createStaffAccount'),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            loc.translate('registerStaffSubtitle'),
                            style: TextStyle(
                              fontSize: 13.5,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Role Selector
                          DropdownButtonFormField<UserRole>(
                            initialValue: selectedRole,
                            dropdownColor: isDark ? AppColors.cardDark : Colors.white,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              labelText: loc.translate('roleInClinic'),
                              prefixIcon: const Icon(
                                Icons.badge_outlined,
                                color: AppColors.primary,
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.cardDark.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                            ),
                            items: [
                              DropdownMenuItem(
                                value: UserRole.doctor,
                                child: Text(loc.translate('roleDoctor')),
                              ),
                              DropdownMenuItem(
                                value: UserRole.receptionist,
                                child: Text(loc.translate('roleReceptionist')),
                              ),
                              DropdownMenuItem(
                                value: UserRole.clinicStaff,
                                child: Text(loc.translate('roleNurse')),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) setState(() => selectedRole = val);
                            },
                          ),
                          const SizedBox(height: 16),

                          // Email Field
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                            decoration: InputDecoration(
                              labelText: loc.translate('emailLabel'),
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.cardDark.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          TextField(
                            controller: passwordController,
                            obscureText: hidePassword,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                            decoration: InputDecoration(
                              labelText: loc.translate('passwordLabel'),
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.primary,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textMutedLight,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.cardDark.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password Field
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: hideConfirmPassword,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                            decoration: InputDecoration(
                              labelText: loc.translate('confirmPasswordLabel'),
                              prefixIcon: const Icon(
                                Icons.lock_reset_rounded,
                                color: AppColors.primary,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hideConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.textMutedLight,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hideConfirmPassword = !hideConfirmPassword;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.cardDark.withValues(alpha: 0.5)
                                  : Colors.white.withValues(alpha: 0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: AppColors.glassBorderLight,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // Register Button
                          GradientButton(
                            text: loc.translate('createAccount'),
                            isLoading: isLoading,
                            onPressed: signUp,
                            icon: Icons.person_add_alt_1_rounded,
                            borderRadius: 28,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}