# New ports collection makefile for:	pkg_add_it
# Date created:				13 November 2010
# Whom:					Marin Atanasov Nikolov <dnaeon@gmail.com>
#
# $FreeBSD$
#

PORTNAME=	pkg_add_it
PORTVERSION=	1.3
CATEGORIES=	ports-mgmt
MASTER_SITES=	http://www.unix-heaven.org/ports-mgmt/

MAINTAINER=	dnaeon@gmail.com
COMMENT=	Interactive tool for package installation

MAN1=		pkg_add_it.1
MAN5=		pkg_add_it.conf.5
PLIST_FILES=	sbin/pkg_add_it \
		etc/pkg_add_it.conf

PKG_RELEASE!=	/usr/bin/uname -r | /usr/bin/cut -d '-' -f 1,2 | \
			/usr/bin/sed -e 's|\.[0-9]*-STABLE|-STABLE|'

post-patch:
	${REINPLACE_CMD} -e 's|@PKG_ARCH@|${ARCH}|' \
		         -e 's|@PKG_RELEASE@|${PKG_RELEASE:L}|' ${WRKSRC}/pkg_add_it.conf

do-install:
	${CP} ${WRKSRC}/pkg_add_it.conf ${PREFIX}/etc/pkg_add_it.conf
	${INSTALL_PROGRAM} ${WRKSRC}/pkg_add_it ${PREFIX}/sbin/pkg_add_it
	${INSTALL_MAN} ${WRKSRC}/pkg_add_it.1 ${MAN1PREFIX}/man/man1
	${INSTALL_MAN} ${WRKSRC}/pkg_add_it.conf.5 ${MAN5PREFIX}/man/man5

post-install:
	@${ECHO_CMD}
	@${CAT} ${PKGMESSAGE}
	@${ECHO_CMD}

.include <bsd.port.mk>
