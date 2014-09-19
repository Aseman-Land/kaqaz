/*
    Copyright (C) 2014 Sialan Labs
    http://labs.sialan.org

    Kaqaz is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Kaqaz is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef SIALANMIMEAPPS_H
#define SIALANMIMEAPPS_H

#include <QObject>
#include <QStringList>

class SialanMimeAppsPrivate;
class SialanMimeApps: public QObject
{
    Q_OBJECT
public:
    SialanMimeApps( QObject *parent = 0 );
    ~SialanMimeApps();

    Q_INVOKABLE QStringList appsOfMime( const QString & mime );
    Q_INVOKABLE QStringList appsOfFile( const QString & file );

    Q_INVOKABLE QString appName( const QString & app ) const;
    Q_INVOKABLE QString appIcon( const QString & app ) const;
    Q_INVOKABLE QString appGenericName( const QString & app ) const;
    Q_INVOKABLE QString appComment( const QString & app ) const;
    Q_INVOKABLE QString appPath( const QString & app ) const;
    Q_INVOKABLE QString appCommand( const QString & app ) const;
    Q_INVOKABLE QStringList appMimes( const QString & app ) const;

public slots:
    void openFiles( const QString & app, const QStringList & files );

private:
    SialanMimeAppsPrivate *p;
};

#endif // SIALANMIMEAPPS_H
