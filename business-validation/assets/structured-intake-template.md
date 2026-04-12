# Client Intake Questionnaire

Use this when a client braindump is not available. Ask these questions interactively to build the structured context needed for business validation.

## Section 1: The Basics (Required)

1. **What's the brand/product name?**

2. **What exactly are you selling?** (Describe the product or service in 2-3 sentences. What does it do? What problem does it solve?)

3. **What category is this?** (e.g., health supplement, skincare, SaaS tool, physical product, professional service)

4. **Where are your customers?** (Primary market and percentage split, e.g., "UK 80%, US 20%")

5. **What's your current revenue?** (Options: pre-launch / under $10k/month / $10-50k/month / $50-100k/month / $100k+/month)

6. **What's your pricing and offer structure?** (Include all tiers, bundles, subscriptions if applicable)

7. **Who do you think your ideal customer is?** (Describe 1-3 customer types. Not demographics -- describe their situation, frustration, and what they've tried before.)

8. **Who are your top 2-3 competitors?** (Include URLs if possible)

## Section 2: Deeper Context (Highly Valuable)

9. **Why do you believe this will work?** (What's your core thesis? What makes you confident?)

10. **What makes you different from alternatives?** (List your top 3 differentiators)

11. **Do you have existing marketing assets?** (Share URLs for: website, funnels, landing pages, ad library links, social media)

12. **What's working best right now?** (Your top-performing ad, funnel, or content piece)

13. **Have you identified specific customer segments?** (If yes, describe each with how they self-identify and their emotional state)

## Section 3: Economics (Improves Quality Significantly)

14. **What are your unit economics?** (COGS per unit, gross margin percentage, contribution margin if known)

15. **What does it cost to acquire a customer?** (CAC by channel if known, or overall average)

16. **Do customers buy more than once?** (Repeat purchase rate, subscription rate, or LTV if known)

## Section 4: Context (Nice to Have)

17. **What's your budget for the next 6 months?** (Marketing/growth budget specifically)

18. **Is there a specific timeline or deadline?** (Launch date, funding runway, seasonal window)

19. **What's your background?** (Industry experience, previous ventures, team size)

20. **What are you most worried about?** (Your biggest concern or uncertainty about this business)

---

## After Collecting Responses

Map answers to the extraction fields:
- Q1 -> product_name
- Q2 -> product_description
- Q3 -> category
- Q4 -> geography
- Q5 -> revenue_stage
- Q6 -> pricing
- Q7 -> target_customers, customer_segments
- Q8 -> competitors
- Q9 -> founder_assumptions (raw material)
- Q10 -> differentiators
- Q11 -> existing_assets
- Q12 -> top_performing_content
- Q13 -> customer_segments (detailed)
- Q14 -> unit_economics
- Q15 -> cac_by_channel
- Q16 -> ltv
- Q17 -> budget_constraints
- Q18 -> timeline
- Q19 -> founder_background
- Q20 -> (factor into risk analysis)

Then proceed to Step 2 (Auto-Detect) in the main SKILL.md workflow.
