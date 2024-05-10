osl-nginx CHANGELOG
===================

This file is used to list changes made in each version of the
osl-nginx cookbook.

6.6.2 (2024-05-10)
------------------
- Test Kitchen Config Refactor

6.6.1 (2023-07-25)
------------------
- Remove template-based code from file

6.6.0 (2023-07-25)
------------------
- Various fixes

6.5.0 (2023-07-24)
------------------
- Add a default DH parameters file

6.4.0 (2023-06-02)
------------------
- Upgrade Nginx dependency to patch converge error

6.3.0 (2021-11-02)
------------------
- Update logrotate to 3.0.0

6.2.0 (2021-07-15)
------------------
- Upgrade nginx to >= 12.0

6.1.1 (2021-06-17)
------------------
- Match version we use in base cookbook for logrotate

6.1.0 (2021-06-17)
------------------
- Set unified_mode for custom resources

6.0.0 (2021-05-25)
------------------
- Update to new osl-firewall resources

5.1.0 (2021-04-06)
------------------
- Update Chef dependency to >= 16

5.0.0 (2021-03-12)
------------------
- Update to use nginx 11.4 cookbook

4.3.0 (2021-02-19)
------------------
- Remove munin

4.2.0 (2021-02-13)
------------------
- Deprovision etherpad-lite

4.1.0 (2020-10-28)
------------------
- CentOS 8 support

4.0.2 (2020-10-02)
------------------
- Bump to nginx 10.3.2

4.0.1 (2020-09-25)
------------------
- Use library helpers instead of attributes which no longer exist

4.0.0 (2020-09-24)
------------------
- Update to support nginx 10.x

3.3.0 (2020-09-04)
------------------
- Chef 16 Fixes

3.2.0 (2020-07-02)
------------------
- Chef 15 fixes

3.1.1 (2020-01-07)
------------------
- Chef 14 post-migration fixes

3.1.0 (2019-10-30)
------------------
- Chef 14 compatibility fixes

3.0.1 (2018-10-22)
------------------
- Remove server block for SSL on etherpad-lite

3.0.0 (2018-09-12)
------------------
- Chef 13 compatibility fixes

2.1.2 (2017-10-13)
------------------
- User newer chef_nginx cookbook 6.2.0

2.1.1 (2017-08-23)
------------------
- Disable SSLv2/3 and update ciphers for etherpad-lite

2.1.0 (2017-08-23)
------------------
- Massive cleanup

2.0.0 (2017-07-03)
------------------
- Switch to chef_nginx
