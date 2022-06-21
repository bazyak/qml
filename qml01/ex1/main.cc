#include "main_window.h"

#include <QApplication>
#include <QFile>
#include <QString>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;

    QFile file { ":/styles.qss" };
    file.open(QIODevice::ReadOnly);
    QString const qss_style { file.readAll() };
    if (!qss_style.isEmpty())
    {
        w.setStyleSheet(qss_style);
    }

    w.show();
    return a.exec();
}
