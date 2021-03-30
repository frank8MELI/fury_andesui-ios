# Contributing

Thank you for wanting to contribute! Remember to check out the wiki and please make sure to follow this guide when contributing.

## Did you find a bug?

- Ensure the bug was not already reported by searching on GitHub under Issues.
- If you're unable to find an open issue addressing the problem, open a new one. Be sure to include a title and clear description, as much relevant information as possible.

## Do you want to patch a bug or want to add a feature?

- Make sure there's an issue for what you want to add.
    - If there isn't an issue, open one and assign it to the maintainer.
- Fork the project and branch out of develop.
- Follow this naming convention:
    - For a fix, the branch name should start with `fix/`
    - For a feature (be it new or a feature of a feature), the branch name should start with `feature/`
    - After the category, the name should be at most three words long, all in lowercase and hyphen-separated.
    - Example: `feature/debounce`, `fix/question-box-height`
- Work on your branch normally.
- Each commit should be significant on its own and should reference the issue number.
- Once finished, open a new GitHub pull request with the fix or feature.
- The title should be meaningful and short.
- Ensure the PR description clearly describes the problem and solution. Include the relevant issue number.
- Assign or notify one of the maintainers. You can contact us at 
- Add as many reviewers as possible, ideally developers that this change will impact.

### Make sure
- All PRs must contemplate unit tests for new functionality, and current tests should pass
- All PRs must contemplate linters. No errors or warnings should be thrown.