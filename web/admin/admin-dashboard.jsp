<%-- 
    Document   : admin-dashboard
    Created on : May 30, 2026, 2:19:48 PM
    Author     : Asus
--%>

<%@page import="dto.Admin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Admin admin = (Admin) session.getAttribute("ADMIN_USER");
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard | AutoWashPro Staff</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <!-- STAFF TOP NAVIGATION -->
        <header class="site-header">
            <div class="site-header__container main-wrapper">
                <a href="admin-dashboard.html" class="site-header__logo">
                    <div class="site-header__logo-icon" style="background: linear-gradient(135deg, var(--color-accent-blue), var(--color-accent-cyan));"></div>
                    <div class="site-header__logo-text">ADMIN<span>PANEL</span></div>
                </a>
                <nav class="site-header__navigation">
                    <a href="#" class="site-header__nav-link site-header__nav-link--active">Dashboard</a>
                    <a href="MainController?action=viewCustomerManagement" class="site-header__nav-link">Customers</a>
                    <a href="booking-management.jsp" class="site-header__nav-link">Bookings</a>
                    <a href="loyalty-management.jsp" class="site-header__nav-link">Loyalty</a>
                </nav>
                <div class="site-header__actions">
                    <span class="status-badge status-badge--completed">Staff Portal</span>
                    <a href="MainController?action=logout" class="btn btn--secondary btn--sm">Logout</a>
                </div>
            </div>
        </header>

        <!-- ADMIN CONTENT -->
        <main class="main-wrapper" style="margin-top: var(--spacing-xl);">

            <!-- OPERATIONS OVERVIEW HERO -->
            <section class="glass-panel" style="padding: var(--spacing-xl); border-radius: var(--radius-xl); margin-bottom: var(--spacing-xl); position: relative; overflow: hidden;">
                <div style="position: absolute; top:0; right:0; width: 300px; height: 100%; background: radial-gradient(circle, var(--color-accent-cyan-glow) 0%, transparent 70%); pointer-events: none;"></div>
                <span style="font-size: 0.75rem; font-weight: 700; color: var(--color-accent-cyan); text-transform: uppercase; letter-spacing: 0.1em;">Operations Control</span>
                <h1 style="font-size: 2.0rem; margin-top: var(--spacing-xs); margin-bottom: var(--spacing-sm);">Welcome back  <%= admin.getFullName()%> </h1>
                <p style="max-width: 700px; color: var(--color-text-secondary); font-size: 0.95rem;">System status is nominal. RFID gate scanning is online, 4 wash bays are currently active, and premium detaiil logs are synced.</p>
                <div style="display: flex; gap: var(--spacing-md); margin-top: var(--spacing-lg);">
                    <a href="booking-management.html" class="btn btn--primary btn--sm">View Today's Bookings</a>
                    <a href="reports.html" class="btn btn--secondary btn--sm">Generate Shift Report</a>
                </div>
            </section>

            <!-- QUICK STATS -->
            <section style="margin-bottom: var(--spacing-xl);">
                <div class="grid-cols-4">
                    <!-- Stat 1: Customers -->
                    <div class="stat-card glass-panel">
                        <div class="stat-card__header">
                            <span class="stat-card__label">Total Active Customers</span>
                            <div class="stat-card__icon" style="color: var(--color-accent-blue);">
                                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2M9 11a4 4 0 100-8 4 4 0 000 8z"></path></svg>
                            </div>
                        </div>
                        <div class="stat-card__body">
                            <span class="stat-card__value">${totalCustomers}</span>
                            <span class="stat-card__change stat-card__change--up"></span> <!<!-- See new signup customers -->
                        </div>
                    </div>

                    <!-- Stat 2: Active Bookings -->
                    <div class="stat-card glass-panel">
                        <div class="stat-card__header">
                            <span class="stat-card__label">Total Vehicles</span>
                            <div class="stat-card__icon" style="color: var(--color-accent-cyan);">
                                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            </div>
                        </div>
                        <div class="stat-card__body">
                            <span class="stat-card__value">${totalVehicles}</span>
                            <span class="stat-card__change stat-card__change--up"></span> <!<!-- See new register car -->
                        </div>
                    </div>

                    <!-- Stat 3: Revenue -->
                    <div class="stat-card glass-panel">
                        <div class="stat-card__header">
                            <span class="stat-card__label">Today's Revenue</span>
                            <div class="stat-card__icon" style="color: var(--color-accent-gold);">
                                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="2" y="5" width="20" height="14" rx="2" ry="2"></rect><line x1="2" y1="10" x2="22" y2="10"></line></svg>
                            </div>
                        </div>
                        <div class="stat-card__body">
                            <span class="stat-card__value">...</span> <!<!-- comming soon -->
                            <span class="stat-card__change stat-card__change--up">...</span>
                        </div>
                    </div>

                    <!-- Stat 4: Loyalty Transactions -->
                    <div class="stat-card glass-panel">
                        <div class="stat-card__header">
                            <span class="stat-card__label">Total Bookings</span>
                            <div class="stat-card__icon" style="color: var(--color-accent-orange);">
                                <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                            </div>
                        </div>
                        <div class="stat-card__body">
                            <span class="stat-card__value">...</span> <!<!--  waiting for booking  -->
                            <span class="stat-card__change stat-card__change--up">...</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- LIVE DATA VIEWS -->
            <div class="grid-cols-2" style="margin-bottom: var(--spacing-xl);">

                <!-- Left Column: Booking Overview -->
                <div class="glass-panel" style="padding: var(--spacing-lg); border-radius: var(--radius-xl);">
                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:var(--spacing-md);">
                        <h2 style="font-size:1.25rem;">Live Booking Desk</h2>
                        <a href="booking-management.html" class="btn btn--secondary btn--sm">View All</a>
                    </div>

                    <div class="data-table-wrapper">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Customer</th>
                                    <th>Bay / Time</th>
                                    <th>Service</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="font-weight:600; color:var(--color-text-primary);">Kenji T.</td>
                                    <td>Bay 3 @ 10:30 AM</td>
                                    <td>Graphene Coating</td>
                                    <td><span class="status-badge status-badge--pending">Confirmed</span></td>
                                </tr>
                                <tr>
                                    <td style="font-weight:600; color:var(--color-text-primary);">Keiko M.</td>
                                    <td>Bay 1 @ 11:00 AM</td>
                                    <td>Ceramic Wash</td>
                                    <td><span class="status-badge status-badge--pending">Pending</span></td>
                                </tr>
                                <tr>
                                    <td style="font-weight:600; color:var(--color-text-primary);">Satoshi K.</td>
                                    <td>Bay 2 @ 09:15 AM</td>
                                    <td>Interior Detailing</td>
                                    <td><span class="status-badge status-badge--completed">Active</span></td>
                                </tr>
                                <tr>
                                    <td style="font-weight:600; color:var(--color-text-primary);">Yukiko H.</td>
                                    <td>Bay 4 @ 08:30 AM</td>
                                    <td>Express Wash</td>
                                    <td><span class="status-badge status-badge--completed">Completed</span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Right Column: Customer Tier Overview -->
                <div class="glass-panel admin-tier-overview"
                     style="padding: var(--spacing-lg); border-radius: var(--radius-xl);">

                    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:var(--spacing-md);">
                        <h2 style="font-size:1.25rem;">Customer Tier Overview</h2>
                        <a href="MainController?action=viewCustomerManagement" class="btn btn--secondary btn--sm">
                            View Details
                        </a>
                    </div>

                    <div class="data-table-wrapper">
                        <table class="data-table admin-tier-overview__table">
                            <thead>
                                <tr>
                                    <th>Tier</th>
                                    <th>Customers</th>
                                    <th>Percentage</th>
                                    <th>Progress</th>
                                </tr>
                            </thead>

                            <tbody>

                                <tr>
                                    <td>
                                        <span class="status-badge status-badge--platinum">
                                            Platinum
                                        </span>
                                    </td>
                                    <td>24</td>
                                    <td>12%</td>
                                    <td>
                                        <div class="admin-tier-overview__progress-bar">
                                            <div class="admin-tier-overview__progress-fill admin-tier-overview__progress-fill--platinum"
                                                 style="width:12%;">
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <span class="status-badge status-badge--gold">
                                            Gold
                                        </span>
                                    </td>
                                    <td>48</td>
                                    <td>24%</td>
                                    <td>
                                        <div class="admin-tier-overview__progress-bar">
                                            <div class="admin-tier-overview__progress-fill admin-tier-overview__progress-fill--gold"
                                                 style="width:24%;">
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <span class="status-badge status-badge--silver">
                                            Silver
                                        </span>
                                    </td>
                                    <td>72</td>
                                    <td>36%</td>
                                    <td>
                                        <div class="admin-tier-overview__progress-bar">
                                            <div class="admin-tier-overview__progress-fill admin-tier-overview__progress-fill--silver"
                                                 style="width:36%;">
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <span class="status-badge status-badge--member">
                                            Member
                                        </span>
                                    </td>
                                    <td>56</td>
                                    <td>28%</td>
                                    <td>
                                        <div class="admin-tier-overview__progress-bar">
                                            <div class="admin-tier-overview__progress-fill admin-tier-overview__progress-fill--member"
                                                 style="width:28%;">
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- RECENT ACTIVITY FEED -->
                <section class="glass-panel" style="padding: var(--spacing-xl); border-radius: var(--radius-xl); margin-bottom: var(--spacing-xl);">
                    <h2 style="font-size:1.25rem; margin-bottom:var(--spacing-lg);">Live Operations Log</h2>

                    <div class="activity-timeline">
                        <div class="activity-timeline__item">
                            <div class="activity-timeline__dot activity-timeline__dot--booking"></div>
                            <div class="activity-timeline__content">
                                <span class="activity-timeline__time">Just Now</span>
                                <span class="activity-timeline__title">Vehicle Checked In (RFID Gate 1)</span>
                                <span class="activity-timeline__desc">Lexus LS 500h (Plate: 足立 330 す 78-90) scanned. System checked in booking ID #4928.</span>
                            </div>
                        </div>

                        <div class="activity-timeline__item">
                            <div class="activity-timeline__dot activity-timeline__dot--loyalty"></div>
                            <div class="activity-timeline__content">
                                <span class="activity-timeline__time">12 minutes ago</span>
                                <span class="activity-timeline__title">Loyalty Reward Redeemed</span>
                                <span class="activity-timeline__desc">Akira Tanaka redeemed 1,000 points for a free cabin sanitizer upgrade.</span>
                            </div>
                        </div>

                        <div class="activity-timeline__item">
                            <div class="activity-timeline__dot activity-timeline__dot--booking"></div>
                            <div class="activity-timeline__content">
                                <span class="activity-timeline__time">45 minutes ago</span>
                                <span class="activity-timeline__title">New Booking Scheduled</span>
                                <span class="activity-timeline__desc">Customer Kenji Takahashi booked a Signature Graphene detailing wash for June 04.</span>
                            </div>
                        </div>
                    </div>
                </section>

        </main>

        <!-- STAFF FOOTER -->
        <footer class="site-footer" style="margin-top: var(--spacing-xxl);">
            <div class="site-footer__container main-wrapper">
                <div class="site-footer__bottom">
                    <p>&copy; 2026 AutoWashPro Operations Desk. Restricted Access.</p>
                    <a href="MainController?action=logout" class="site-footer__staff-link">Return to Customer Landing</a>
                </div>
            </div>
        </footer>

    </body>
</html>

