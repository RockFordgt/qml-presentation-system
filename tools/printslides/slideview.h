/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the QML Presentation System.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/


#ifndef SLIDEVIEW_H
#define SLIDEVIEW_H

#include <QQuickView>
#include <QOpenGLFramebufferObject>
#include <QPrinter>
#include <QPainter>

/** A class for viewing and printing a QML Presentation with Slides.
    Assumes the root object of the QML file that was loaded is derived from
    Presentation from qt-labs qml-presentation-system
    @author Alan Ezust
*/
class SlideView : public QQuickView {
    Q_OBJECT
public:
    SlideView(QWindow* parent=0);
public slots:
    void updateStatus(QQuickView::Status);
    void timerEvent(QTimerEvent* evt);
    void printCurrentSlide();
    void goToNextSlide();

private:
     QQuickItem *m_rootItem;
    int m_slidesCount;
    int m_currentSlide;
    int m_tid;
    QRect m_paintRect;

    QPrinter m_printer;
    QPainter m_painter;
    QOpenGLFramebufferObject *m_fbo;
};

#endif        //  #ifndef SLIDEVIEW_H
