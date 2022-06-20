#pragma once

#include <QMainWindow>
#include <QString>
#include <QVariant>

#include <memory>

class QPalette;
// class CustomLineEdit; // needed for solution 2

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget* parent = nullptr);
    ~MainWindow();

private slots:
    void checkCredentials();

private:
    void failAnimation();
    void successAnimation();
    static QVariant paletteInterpolator(QPalette const& start, QPalette const& end, qreal progress);

    static inline QString const kLogin { "login" };
    static inline QString const kPassword { "password" };
    static inline QString const kEditColor { "#535353" };

    std::unique_ptr<Ui::MainWindow> ui;
    // CustomLineEdit* loginTextField { nullptr }; // needed for sulution 2
};
