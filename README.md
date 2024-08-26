# zelda
Project Zelda repo


Welcome to our project -  Zero Trust Security in Serverless Application deployment.
Before we delve into the walkthrough and toolchain required for this lab, it would be beneficial to readthrough the AWS CIS Benchmark white paper just to understand the best practices and recommendation for configuring security options for a subset of AWS services with an emphasis on foundational, testable, and architecture agnostic settings. https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf

Zero Trust Security
Zero Trust and the Center for Internet Security (CIS) both play significant roles in enhancing cybersecurity frameworks, but they focus on different aspects of securing an organization's infrastructure. Here's how they intersect and complement each other:

Zero Trust Security Model
Principle: "Never trust, always verify." This approach assumes that threats could come from inside or outside the network. It operates on the idea that trust is not automatically given to any user or device, even if it’s inside the corporate network. Every access request is fully authenticated, authorized, and encrypted before granting access.
Core Components:
Microsegmentation: Dividing the network into smaller zones to contain breaches.
Least Privilege Access: Limiting user access rights to the minimum necessary.
Continuous Monitoring: Constantly monitoring and logging activity to detect and respond to threats quickly.
Strong Authentication: Implementing multi-factor authentication (MFA) and other stringent verification methods.
CIS Controls
Principle: A set of best practices and guidelines designed to help organizations secure their systems and data against cyber threats. The CIS Controls are a prioritized set of actions to protect organizations from known cyber-attack vectors.
Core Components:
CIS Controls Version 8: The latest version groups controls into three implementation groups (IG1, IG2, IG3) based on the organization's size and risk profile.
20 Key Controls: Includes aspects like inventory and control of hardware/software assets, continuous vulnerability management, controlled use of administrative privileges, secure configuration, and data protection.
Intersection of Zero Trust and CIS
Control Alignment: CIS Controls support the implementation of a Zero Trust architecture. For example:

CIS Control 4: Secure Configuration of Enterprise Assets and Software aligns with Zero Trust’s microsegmentation by ensuring that all systems are securely configured and segmented to minimize the attack surface.
CIS Control 5: Account Management supports Zero Trust’s principle of least privilege by ensuring only authorized users have access to resources.
CIS Control 14: Security Awareness and Skills Training is crucial for Zero Trust, emphasizing that users should be aware of the principles of Zero Trust and how to operate within a Zero Trust environment.
Zero Trust as an Extension of CIS: While CIS provides a comprehensive list of actions to secure an organization's infrastructure, Zero Trust builds on this by implementing a more granular and continuous verification approach. The Zero Trust model can be seen as a strategic way to achieve the goals set out by the CIS Controls.

Implementing Zero Trust with CIS Controls
Assessment: Start by assessing the current security posture using the CIS Controls as a benchmark.
Planning: Develop a plan to implement Zero Trust principles, mapping these to the relevant CIS Controls.
Execution: Implement Zero Trust security measures in line with CIS guidelines, ensuring continuous monitoring and adjustment.
In summary, Zero Trust and CIS are complementary frameworks. The CIS Controls provide a solid foundation for cybersecurity, while Zero Trust adds an extra layer of defense by eliminating implicit trust within the network, ensuring that every user, device, and application is continuously verified before accessing resources.