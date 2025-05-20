import { locator } from '@qavajs/steps-playwright/po';

export class WikipediaFooter {
    FooterSidebar = locator('.footer-sidebar');
    FooterSidebarContent = locator('.footer-sidebar-content');
    FooterIcon = locator('.footer-sidebar-icon.sprite.svg-Wikimedia-logo_black');
    FooterDescription = locator('.footer-sidebar-text[data-jsl10n="portal.footer-description"]');
    DonationLink = locator('.footer-sidebar-text a[href*="donate.wikimedia.org"]');
    DonationText = locator('.footer-sidebar-text a span[data-jsl10n="footer-donate"]');
}
