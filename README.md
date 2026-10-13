# ALT Zone API Testing – Robot Framework

This repository showcases my practical experience in REST API testing using Robot Framework and RequestsLibrary.

The tests were developed as part of my software testing work on **ALT Zone**, a multiplayer mobile game developed by Psyche's Royale Gaming ry.

## 🔍 What the Tests Cover

The test suite includes six test cases:

1. **Authentication Token Verification** – Checks that an authentication token is available after signing in.
2. **User Profile Retrieval** – Retrieves the authenticated user's profile.
3. **Player Data Inspection** – Retrieves player data for API investigation.
4. **Player Information Retrieval** – Checks the authenticated player's endpoint.
5. **Clan Information Retrieval** – Checks the authenticated player's clan endpoint.
6. **Room List Retrieval** – Retrieves available room data.

The tests verify expected HTTP response codes and demonstrate the use of dynamic identifiers retrieved during authentication.

## 🛠 Tools & Technologies

- Robot Framework
- Python
- RequestsLibrary
- REST API testing
- JSON response handling
- Bearer token authentication

## ⚙️ Test Structure

The test suite uses:

- `Suite Setup` for authentication before test execution
- Environment variables for test credentials
- Dynamic extraction of profile, player, and clan identifiers
- Reusable Robot Framework keywords
- HTTP response status validation

## 🔐 Security

This repository does not contain actual usernames, passwords, or authentication tokens.

Credentials are read from environment variables rather than being stored directly in the test scripts.

The tests are intended for an authorized development environment. Running them requires valid ALT Zone test credentials and permission to access the development API.

Test logs and execution reports should not be published because they may contain sensitive information.

## ▶️ Running the Tests

Install Python and the required Robot Framework libraries.

Configure the following environment variables:

- `ALTZONE_USERNAME`
- `ALTZONE_PASSWORD`

Run the tests using:

`python -m robot --loglevel NONE --log NONE --report NONE --output NONE api_test.robot`

Test execution may still expose sensitive information through error messages. Review terminal output carefully and use only authorized test accounts.

## ✅ Test Execution

*Last verified: October 13, 2026**

- Total tests: 6
- Passed: 6
- Failed: 0
- HTTPS certificate verification: Enabled

All six tests passed successfully against the ALT Zone development API.

The test suite includes HTTP status validation and player ID verification.

## 🤖 AI-Assisted Testing

I use AI assistance to support test script creation, modifications, troubleshooting, and learning.

My practical experience includes executing automated tests, investigating failures, interpreting results, and maintaining test workflows.

I am continuing to develop my independent test scripting skills.

## 📚 Future Improvements

- Additional response content validation
- More negative test cases
- Improved test documentation
- More comprehensive regression testing