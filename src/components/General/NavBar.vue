<template>
  <v-app-bar app color="primary" dark>
    <v-app-bar-nav-icon @click="toggleSidebar" />
    <v-toolbar-title>ECSA-HC ERP</v-toolbar-title>
    <v-spacer></v-spacer>

    <!-- Rest of your top bar links... -->
    <v-btn v-for="link in links" :key="link" text>{{ link }}</v-btn>

    <!-- User Menu -->
    <v-menu bottom left>
      <template v-slot:activator="{ on }">
        <v-btn icon v-on="on">
          <v-avatar>
            <v-img
              src="https://api.lorem.space/image/face?w=80&h=80&hash=af072189"
            />
          </v-avatar>
        </v-btn>
      </template>
      <v-list>
        <v-list-item v-for="item in userLinks" :key="item.title" link>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>

  <!-- Sidebar -->
  <v-navigation-drawer v-model="sidebarOpen" app temporary class="sidebar">
    <!-- User Info -->
    <v-list-item class="user-info">
      <v-list-item-content>
        <v-list-item-title>John Doe</v-list-item-title>
        <v-list-item-subtitle>john.doe@example.com</v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>
    <v-divider></v-divider>
    <!-- Menu Items -->
    <v-list dense class="custom-scroll">
      <v-list-item
        v-for="item in menuItems"
        :key="item.title"
        @click="navigate(item.route)"
      >
        <v-list-item-content class="d-flex align-center">
          <v-icon class="mr-2">{{ item.icon }}</v-icon>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
export default {
  data() {
    return {
      links: ["Dash", "Reports"],
      topLinks: [
        // Define top links as required
        { name: "Dashboard", route: "/dashboard" },
        // Additional top links
      ],
      search: "",
      userLinks: [
        ["mdi-cog", "Settings"],
        ["mdi-logout", "Sign Out"],
      ],
      menuItems: [
        // Dashboard
        { title: "Dashboard", icon: "mdi-view-dashboard", route: "/dashboard" },

        // HR Module

        {
          title: " Projects",
          icon: "mdi-office-building", // Suggested icon for Organization Departments
          route: "/MgtProjects", // Assuming a different route for Departments
        },

        {
          title: " Departments",
          icon: "mdi-office-building", // Suggested icon for Organization Departments
          route: "/MgtDepts", // Assuming a different route for Departments
        },
        {
          title: " Clusters",
          icon: "mdi-account-multiple", // Alternative icon for Organization Clusters
          route: "/MgtClusters", // Assuming a different route for Clusters
        },

        {
          title: " Positions",
          icon: "mdi-account-multiple", // Alternative icon for Organization Clusters
          route: "/MgtPositions", // Assuming a different route for Clusters
        },

        {
          title: "Payroll Labels",
          icon: "mdi-account-multiple", // Alternative icon for Organization Clusters
          route: "/MgtPayrolls", // Assuming a different route for Clusters
        },

        {
          title: "Employee Database",
          icon: "mdi-account-group",
          route: "/MgtEmployees",
        },
        {
          title: "Onboarding & Offboarding",
          icon: "mdi-account-convert",
          route: "/onboarding-offboarding",
        },
        {
          title: "Leave & Absence",
          icon: "mdi-palm-tree",
          route: "/leave-absence",
        },
        {
          title: "Performance Management",
          icon: "mdi-chart-bell-curve",
          route: "/performance-management",
        },
        {
          title: "Benefits & Compensation",
          icon: "mdi-wallet-giftcard",
          route: "/benefits-compensation",
        },
        {
          title: "Workforce Analytics",
          icon: "mdi-chart-timeline-variant",
          route: "/workforce-analytics",
        },

        // Payroll Module
        {
          title: "Payroll Administration",
          icon: "mdi-cash-register",
          route: "/payroll-administration",
        },
        {
          title: "Compensation Planning",
          icon: "mdi-cash-100",
          route: "/compensation-planning",
        },
        {
          title: "Tax Compliance",
          icon: "mdi-calculator-variant-outline",
          route: "/tax-compliance",
        },
        {
          title: "Payroll Analytics",
          icon: "mdi-chart-areaspline",
          route: "/payroll-analytics",
        },
        {
          title: "Employee Reimbursements",
          icon: "mdi-cash-refund",
          route: "/employee-reimbursements",
        },

        // Finance Module
        {
          title: "Financial Overview",
          icon: "mdi-finance",
          route: "/financial-overview",
        },
        {
          title: "Budget Management",
          icon: "mdi-bank-outline",
          route: "/budget-management",
        },
        {
          title: "Expenditure Tracking",
          icon: "mdi-credit-card-clock",
          route: "/expenditure-tracking",
        },
        {
          title: "Revenue Management",
          icon: "mdi-cash-multiple",
          route: "/revenue-management",
        },
        {
          title: "Financial Compliance",
          icon: "mdi-scale-balance",
          route: "/financial-compliance",
        },
        {
          title: "Asset & Liability",
          icon: "mdi-bank",
          route: "/asset-liability",
        },

        // System Management
        {
          title: "User Management",
          icon: "mdi-account-multiple",
          route: "/user-management",
        },
        {
          title: "System Configuration",
          icon: "mdi-cog-outline",
          route: "/system-configuration",
        },
        {
          title: "Security & Access",
          icon: "mdi-security",
          route: "/security-access",
        },

        // Analytics and Reporting
        {
          title: "Data Analytics",
          icon: "mdi-database-search",
          route: "/data-analytics",
        },
        {
          title: "Custom Reports",
          icon: "mdi-file-chart-outline",
          route: "/custom-reports",
        },

        // Support and Resources
        {
          title: "Support Center",
          icon: "mdi-lifebuoy",
          route: "/support-center",
        },
        {
          title: "Knowledge Base",
          icon: "mdi-book-open-page-variant",
          route: "/knowledge-base",
        },
        {
          title: "System Updates",
          icon: "mdi-update",
          route: "/system-updates",
        },
        {
          title: "Notifications & Alerts",
          icon: "mdi-bell-ring-outline",
          route: "/notifications-alerts",
        },
      ],

      sidebarOpen: false,
      departmentModal: false,
      positionModal: false,
      department: { name: "", description: "" },
      position: { title: "", description: "" },
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarOpen = !this.sidebarOpen;
    },
    navigateTo(route) {
      this.$router.push(route);
    },
    showDepartmentModal() {
      this.departmentModal = true;
    },
    closeDepartmentModal() {
      this.departmentModal = false;
    },
    saveDepartment() {
      // Logic to save department
      // Example: API call to save department data
      this.closeDepartmentModal();
    },
    showPositionModal() {
      this.positionModal = true;
    },
    closePositionModal() {
      this.positionModal = false;
    },
    savePosition() {
      // Logic to save position
      // Example: API call to save position data
      this.closePositionModal();
    },
    onUserLinkClick() {
      // Handle user link clicks
      // Example: Navigate to different settings or logout
    },
    navigate(route) {
      // Example: Navigate to a specific route
      this.$router.push(route);
    },
  },
};
</script>
