# Small Team FlowWave Setup

Complete FlowWave implementation for a small team (2-5 developers).

## 👥 Team Profile

**Ideal for:**
- Startups with small engineering teams
- Side projects with a few contributors
- Small product teams in larger organizations
- Teams new to structured workflows

**Team characteristics:**
- 2-5 developers
- Flat hierarchy
- Quick iteration cycles
- Minimal process overhead desired

## 🎯 What's Included

This example provides:
- Simple PR review workflow
- Basic CI pipeline
- Issue templates
- Minimal documentation requirements
- Flexible branch strategy

## 📁 Files Included

```
.github/
├── workflows/
│   ├── pr-review.yml          # PR validation and auto-assignment
│   ├── ci.yml                 # Basic continuous integration
│   └── weekly-cleanup.yml     # Automated housekeeping
├── ISSUE_TEMPLATE/
│   ├── bug_report.md
│   └── feature_request.md
└── PULL_REQUEST_TEMPLATE.md
```

## 🚀 Quick Setup (15 minutes)

### Step 1: Copy Files (2 min)

```bash
# From the FlowWave repository
cd your-project/
cp -r examples/small-team/.github .
```

### Step 2: Configure GitHub (5 min)

1. **Branch Protection**:
   - Go to Settings > Branches
   - Protect `main` branch
   - Require 1 PR review
   - Require status checks

2. **Team Setup**:
   - Add team members to repository
   - Set appropriate permissions
   - Configure notifications

### Step 3: Customize (5 min)

Update these files with your project specifics:

```yaml
# .github/workflows/pr-review.yml
# Line 20: Update reviewer list
reviewers: ['your-username', 'teammate-username']

# .github/workflows/ci.yml  
# Update build/test commands for your project
```

### Step 4: Test (3 min)

Create a test PR to verify:
```bash
git checkout -b test/workflow
echo "# Test" >> TEST.md
git add TEST.md
git commit -m "test: verify workflow setup"
git push origin test/workflow
# Open PR in GitHub UI
```

## 📋 Workflow Details

### PR Review Workflow

**Triggers**: On PR open, update, or reopen

**Actions**:
1. Validates PR title and description
2. Automatically assigns reviewers
3. Adds labels based on files changed
4. Posts welcome comment with checklist

**Benefits**:
- Consistent PR format
- Faster review assignment
- Clear expectations

### CI Workflow

**Triggers**: On push to PR or main

**Actions**:
1. Runs linting
2. Executes tests
3. Reports coverage
4. Checks for security issues

**Benefits**:
- Catches issues early
- Maintains code quality
- Automates testing

### Weekly Cleanup

**Triggers**: Every Sunday at 00:00 UTC

**Actions**:
1. Closes stale issues
2. Reminds about old PRs
3. Cleans up old branches

**Benefits**:
- Keeps repo organized
- Reduces clutter
- Improves focus

## 🎨 Customization Guide

### Adjust Review Requirements

For very small teams (2-3 people), you might want:

```yaml
# Reduce required reviewers
required_approving_review_count: 1

# Allow self-merge for docs
allow_self_merge: true
```

### Simplify CI for Prototypes

If you're in rapid prototyping mode:

```yaml
# Optional: Skip tests on draft PRs
if: github.event.pull_request.draft == false
```

### Add Simple Deployment

For automatic deploys to staging:

```yaml
- name: Deploy to Staging
  if: github.ref == 'refs/heads/develop'
  run: |
    # Your deployment script
    ./deploy-staging.sh
```

## 📊 Recommended Practices

### Branch Strategy

Keep it simple:
```
main (production, protected)
  ├── feature/new-feature
  ├── fix/bug-fix
  └── docs/update-readme
```

### PR Guidelines

- Keep PRs small (< 300 lines)
- Merge frequently
- Delete branches after merge
- Review within 24 hours

### Communication

- Use PR comments for technical discussion
- Use issues for feature planning
- Use Slack/Discord for quick questions
- Weekly sync meetings (optional)

## 🎯 Success Metrics

Track these to measure effectiveness:

| Metric | Target | How to Improve |
|--------|--------|----------------|
| Time to first review | < 24 hours | Set up notifications |
| PR cycle time | < 3 days | Smaller PRs, faster reviews |
| Build success rate | > 95% | Better testing, pre-commit hooks |
| Stale PRs | < 2 | Regular cleanup, weekly reviews |

## 🔧 Tools Integration

### Recommended Additions

1. **Slack/Discord Notifications**
   ```yaml
   - name: Notify Team
     uses: 8398a7/action-slack@v3
   ```

2. **Automated Dependency Updates**
   ```yaml
   # Use Dependabot
   version: 2
   updates:
     - package-ecosystem: "npm"
   ```

3. **Code Coverage Reports**
   ```yaml
   - name: Upload Coverage
     uses: codecov/codecov-action@v3
   ```

## ⚠️ Common Pitfalls

### 1. Over-Engineering
**Problem**: Adding too many checks too fast
**Solution**: Start minimal, add features as needed

### 2. Notification Fatigue  
**Problem**: Too many automated notifications
**Solution**: Be selective about what triggers notifications

### 3. Slow CI
**Problem**: Tests take too long, blocking merges
**Solution**: Parallelize tests, use caching, keep tests fast

### 4. Merge Conflicts
**Problem**: Long-lived branches cause conflicts
**Solution**: Merge frequently, keep branches short-lived

## 📖 Learning Path

**Week 1**: Basic setup
- Install workflows
- Create first PRs
- Get comfortable with process

**Week 2**: Customization
- Adjust settings to team needs
- Add team-specific labels
- Customize notifications

**Week 3**: Optimization
- Review what's working
- Remove unused features
- Add missing features

**Week 4+**: Continuous improvement
- Track metrics
- Gather team feedback
- Iterate on process

## 🆘 Troubleshooting

### Workflows Not Running

**Check**:
1. File location: `.github/workflows/*.yml`
2. YAML syntax validity
3. Branch name filters
4. GitHub Actions enabled in repo settings

### Reviews Blocking Progress

**Solutions**:
- Reduce required reviewer count to 1
- Enable "Dismiss stale reviews"
- Set review time expectations
- Use async code reviews

### Too Much Process

**Simplify**:
- Remove optional checks
- Reduce required fields in templates
- Make templates more flexible
- Focus on high-value automation only

## 🔗 Next Steps

Once comfortable with this setup:

1. **Add more automation**:
   - Automatic changelog generation
   - Release automation
   - Deployment pipelines

2. **Explore advanced features**:
   - Matrix builds
   - Conditional workflows
   - Reusable workflows

3. **Scale up**:
   - Check out [Medium Team Example](../medium-team/)
   - Learn about [Advanced Workflows](../../docs/advanced-workflows.md)

## 💬 Feedback

This setup working for your team? Have suggestions? 

- Open an [issue](https://github.com/emezeta/g3w/issues)
- Start a [discussion](https://github.com/emezeta/g3w/discussions)
- Submit improvements via PR

## 📝 Changelog

- v1.0.0 - Initial small team setup example

---

*Keep it simple, iterate frequently, and focus on what adds value to your team!*
