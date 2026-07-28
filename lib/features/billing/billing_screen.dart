import 'package:flutter/material.dart';
import '../../core/constants/app_enums.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../shared/models/invoice_model.dart';
import '../../shared/repositories/billing_repository.dart';
import '../../shared/widgets/custom_search_bar.dart';
import '../../shared/widgets/empty_state_widget.dart';
import '../../shared/widgets/invoice_card.dart';
import '../../shared/widgets/loading_widget.dart';
import '../../shared/widgets/stat_card.dart';
import 'create_invoice_dialog.dart';
import 'invoice_detail_dialog.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final BillingRepository _billingRepo = MockBillingRepository();
  final TextEditingController _searchController = TextEditingController();

  List<InvoiceModel> _invoices = [];
  List<InvoiceModel> _filteredInvoices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  Future<void> _fetchInvoices() async {
    setState(() => _isLoading = true);
    final list = await _billingRepo.getInvoices();
    if (mounted) {
      setState(() {
        _invoices = list;
        _filteredInvoices = list;
        _isLoading = false;
      });
    }
  }

  void _onSearch(String query) {
    setState(() {
      _filteredInvoices = _invoices.where((inv) {
        return inv.patientName.toLowerCase().contains(query.toLowerCase()) ||
            inv.invoiceNumber.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  double get _totalCollected => _invoices
      .where((i) => i.status == PaymentStatus.paid)
      .fold(0, (sum, i) => sum + i.totalAmount);

  double get _totalPending => _invoices
      .where((i) => i.status != PaymentStatus.paid)
      .fold(0, (sum, i) => sum + i.totalAmount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Invoices'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.primary),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading billing records...')
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Financial summary cards
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Collected Revenue',
                            value: AppFormatters.formatCurrency(_totalCollected),
                            icon: Icons.account_balance_wallet_rounded,
                            color: AppColors.success,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Pending Balances',
                            value: AppFormatters.formatCurrency(_totalPending),
                            icon: Icons.pending_actions_rounded,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    CustomSearchBar(
                      controller: _searchController,
                      hintText: 'Search invoice # or patient name...',
                      onChanged: _onSearch,
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: _filteredInvoices.isEmpty
                          ? EmptyStateWidget(
                              title: 'No Invoices Found',
                              message: 'No billing records match your search.',
                              icon: Icons.receipt_long_rounded,
                              buttonText: 'Create Invoice',
                              onButtonPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => CreateInvoiceDialog(
                                    onCreated: _fetchInvoices,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 90),
                              itemCount: _filteredInvoices.length,
                              itemBuilder: (context, index) {
                                final invoice = _filteredInvoices[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: InvoiceCard(
                                    invoice: invoice,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => InvoiceDetailDialog(
                                          invoice: invoice,
                                          onStatusUpdated: _fetchInvoices,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreateInvoiceDialog(
              onCreated: _fetchInvoices,
            ),
          );
        },
        icon: const Icon(Icons.add_card_rounded),
        label: const Text('Create Invoice'),
      ),
    );
  }
}