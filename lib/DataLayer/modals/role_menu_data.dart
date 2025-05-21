import 'package:sparsh/features/Appbar/Modals/menu_model.dart';

final Map<String, RoleMenu> menuData = {
  'admin': RoleMenu(
    roleName: 'admin',
    transactionLinks: [
      MenuItem(
        title: 'Financial Accounts',
        subLinks: [
          'Token Scan',
          'Balance Confirmation',
          'Invoice Acknowledgement',
          'Ever White Coupon Generation',
          '194Q Detail Entry',
          'Token Scan Details',
          'Token Scan Report',
          'Token Scan New',
        ],
      ),
      MenuItem(
        title: 'Depot Order',
        subLinks: ['Secondary Sale Capture', 'Order Update', 'Order Entry'],
      ),
      MenuItem(
        title: 'Retailer',
        subLinks: ['Rural Retailer Entry/Update', 'Retailer Registration'],
      ),
      MenuItem(
        title: 'Sales Force',
        subLinks: ['Notification Sent Details', 'User Rating'],
      ),
      MenuItem(
        title: 'Mission Udaan',
        subLinks: [
          'Invoice Cancellation in Bulk',
          'Secondary Sales Invoice Entry',
        ],
      ),
    ],
    reportLinks: [
      MenuItem(
        title: 'SAP Reports',
        subLinks: [
          'Day Summary',
          'Day wise Details',
          'Day Summary Qty/Value Wise',
          'Sales-Purchase-wise Packaging-wise',
          'Year on Year Comparison',
        ],
      ),
      MenuItem(
        title: 'General Reports',
        subLinks: [
          'Pending freight report',
          'Account statement',
          'Contact us',
          'Information document',
        ],
      ),
      MenuItem(
        title: 'MIS Reports',
        subLinks: ['Purchaser aging report (SAP)'],
      ),
      MenuItem(
        title: 'Sales Reports',
        subLinks: ['Product catg-wise sales', 'Sales growth overview YTD/MTD'],
      ),
      MenuItem(
        title: 'Scheme/Discount',
        subLinks: [
          'Purchaser and retailer disbursement details',
          'RPL Outlet tracker',
          'Scheme Disbursement View',
        ],
      ),
      MenuItem(
        title: 'Retailer',
        subLinks: ['Retailer report', 'Retailer KYC details'],
      ),
      MenuItem(title: 'Chart Reports', subLinks: ['Sales overview']),
      MenuItem(title: 'Mobile Reports', subLinks: ['Purchaser 360']),
      MenuItem(
        title: 'Secondary Sale',
        subLinks: [
          'Stock & RollOut data (Tally)',
          'Secondary Sale (Tally)',
          'Stock Data (Tally)',
          'Retailers Sales Report',
          'Retailer Target Vs Actual',
          'My Network',
          'Tally Data Customer Wise',
        ],
      ),
      MenuItem(title: 'Scheme Details', subLinks: ['Schemes Summary']),
    ],
    masterLinks: [
      MenuItem(
        title: 'Customer',
        subLinks: [
          'Purchaser Profile',
          'TAN No Update',
          'SAP Invoice Printing',
        ],
      ),
      MenuItem(
        title: 'Misc Master',
        subLinks: ['Pin Code Master', 'Profile Photo'],
      ),
      MenuItem(
        title: 'Credit Note',
        subLinks: ['Guarantor Orc Entry', 'Guarantor Orc View'],
      ),
    ],
    miscLinks: [
      'Change Password',
      'Software Download',
      'Photo Gallery',
      'SMS Query Code Help',
    ],
  ),

  'custm': RoleMenu(
    roleName: 'custm',
    transactionLinks: [
      MenuItem(
        title: 'Depot Order',
        subLinks: ['Secondary Sale Capture', 'Order Update', 'Order Entry'],
      ),
      MenuItem(
        title: 'Retailer',
        subLinks: ['Rural Retailer Entry/Update', 'Retailer Registration'],
      ),
    ],
    reportLinks: [
      MenuItem(
        title: 'SAP Reports',
        subLinks: [
          'Day Summary',
          'Day wise Details',
          'Day Summary Qty/Value Wise',
        ],
      ),
      MenuItem(
        title: 'General Reports',
        subLinks: ['Pending freight report', 'Account statement'],
      ),
    ],
    masterLinks: [
      MenuItem(title: 'New Links', subLinks: ['MAster123', 'master11']),
      MenuItem(title: 'ajvhfka', subLinks: ['amnsd']),
    ],
    miscLinks: ['Change Password', 'Software Download', 'new links'],
  ),
};
