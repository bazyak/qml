#include "main_window.h"
#include "ui_main_window.h"

#include <QLineEdit>
#include <QPushButton>
#include <QParallelAnimationGroup>
#include <QSequentialAnimationGroup>
#include <QPropertyAnimation>
#include <QVariant>
#include <QPalette>
#include <QColor>
#include <QFrame>
#include <QRect>
#include <QGraphicsOpacityEffect>

#include <memory>

#include "custom_line_edit.h" // needed for solution 2

MainWindow::MainWindow(QWidget* parent)
    : QMainWindow(parent)
    , ui(std::make_unique<Ui::MainWindow>())
{
    ui->setupUi(this);
    Q_INIT_RESOURCE(res);
    setFixedSize(640, 480);
    qRegisterAnimationInterpolator<QPalette>(paletteInterpolator);

    auto palette = ui->loginLineEdit->palette();
    palette.setColor(QPalette::Text, kEditColor);
    ui->loginLineEdit->setPalette(palette);
    ui->passwordLineEdit->setPalette(palette);

    // solution 2 with CustomLineEdit - you have to create objects manualy instead in designer
    /*
    loginTextField = new CustomLineEdit(ui->frame);
    loginTextField->setObjectName("loginTextField");
    loginTextField->setPlaceholderText(tr("Логин"));
    loginTextField->setProperty("textColor", kEditColor);
    loginTextField->setMinimumSize(QSize(0, 40));
    ui->verticalLayout->addWidget(loginTextField);
    */

    connect(ui->loginLineEdit, &QLineEdit::returnPressed, this, &MainWindow::checkCredentials);
    connect(ui->passwordLineEdit, &QLineEdit::returnPressed, this, &MainWindow::checkCredentials);
    connect(ui->submitButton, &QPushButton::clicked, this, &MainWindow::checkCredentials);
}

MainWindow::~MainWindow()
{
}

void MainWindow::checkCredentials()
{
    if (ui->loginLineEdit->text() == kLogin && ui->passwordLineEdit->text() == kPassword)
    {
        successAnimation();
    }
    else
    {
        failAnimation();
    }
}

void MainWindow::failAnimation()
{
    // login and password color animation
    auto from = ui->loginLineEdit->palette();
    auto to = from;
    to.setColor(QPalette::Text, "darkred");

    // solution 2 with CustomLineEdit - you have to use custom QColor property
    /*
    auto fromC = loginTextField->property("textColor");
    auto toC = QColor("darkred");
    auto loginAnim1 = new QPropertyAnimation(loginTextField, "textColor");
    loginAnim1->setDuration(0);
    loginAnim1->setStartValue(fromC);
    loginAnim1->setEndValue(toC);
    auto loginAnim2 = new QPropertyAnimation(loginTextField, "textColor");
    loginAnim2->setDuration(400);
    loginAnim2->setStartValue(toC);
    loginAnim2->setEndValue(fromC);
    */

    auto loginAnim1 = new QPropertyAnimation(ui->loginLineEdit, "palette", this);
    loginAnim1->setDuration(0);
    loginAnim1->setStartValue(from);
    loginAnim1->setEndValue(to);
    auto loginAnim2 = new QPropertyAnimation(ui->loginLineEdit, "palette", this);
    loginAnim2->setDuration(400);
    loginAnim2->setStartValue(to);
    loginAnim2->setEndValue(from);
    auto passwordAnim1 = new QPropertyAnimation(ui->passwordLineEdit, "palette", this);
    passwordAnim1->setDuration(0);
    passwordAnim1->setStartValue(from);
    passwordAnim1->setEndValue(to);
    auto passwordAnim2 = new QPropertyAnimation(ui->passwordLineEdit, "palette", this);
    passwordAnim2->setDuration(400);
    passwordAnim2->setStartValue(to);
    passwordAnim2->setEndValue(from);

    auto loginGroup = new QSequentialAnimationGroup(this);
    loginGroup->addAnimation(loginAnim1);
    loginGroup->addAnimation(loginAnim2);
    auto passwordGroup = new QSequentialAnimationGroup(this);
    passwordGroup->addAnimation(passwordAnim1);
    passwordGroup->addAnimation(passwordAnim2);

    // frame shake animation
    auto start = ui->frame->geometry();
    auto step1 = start.adjusted(-5, 0, -5, 0);
    auto step2 = step1.adjusted(10, 0, 10, 0);
    auto step3 = step2.adjusted(-5, 0, -5, 0);

    auto frameAnim1 = new QPropertyAnimation(ui->frame, "geometry", this);
    frameAnim1->setDuration(50);
    frameAnim1->setStartValue(start);
    frameAnim1->setEndValue(step1);
    auto frameAnim2 = new QPropertyAnimation(ui->frame, "geometry", this);
    frameAnim2->setDuration(100);
    frameAnim2->setStartValue(step1);
    frameAnim2->setEndValue(step2);
    auto frameAnim3 = new QPropertyAnimation(ui->frame, "geometry", this);
    frameAnim3->setDuration(50);
    frameAnim3->setStartValue(step2);
    frameAnim3->setEndValue(step3);

    auto frameGroup = new QSequentialAnimationGroup(this);
    frameGroup->addAnimation(frameAnim1);
    frameGroup->addAnimation(frameAnim2);
    frameGroup->addAnimation(frameAnim3);

    // main parallel animation
    auto mainGroup = new QParallelAnimationGroup(this);
    mainGroup->addAnimation(loginGroup);
    mainGroup->addAnimation(passwordGroup);
    mainGroup->addAnimation(frameGroup);
    mainGroup->start();
}

void MainWindow::successAnimation()
{
    auto loginOpacity = new QGraphicsOpacityEffect(ui->loginLineEdit);
    ui->loginLineEdit->setGraphicsEffect(loginOpacity);
    auto passwordOpacity = new QGraphicsOpacityEffect(ui->passwordLineEdit);
    ui->passwordLineEdit->setGraphicsEffect(passwordOpacity);
    auto submitOpacity = new QGraphicsOpacityEffect(ui->submitButton);
    ui->submitButton->setGraphicsEffect(submitOpacity);

    auto loginAnim = new QPropertyAnimation(loginOpacity, "opacity", this);
    loginAnim->setDuration(400);
    loginAnim->setStartValue(1);
    loginAnim->setEndValue(0);
    auto passwordAnim = new QPropertyAnimation(passwordOpacity, "opacity", this);
    passwordAnim->setDuration(400);
    passwordAnim->setStartValue(1);
    passwordAnim->setEndValue(0);
    auto submitAnim = new QPropertyAnimation(submitOpacity, "opacity", this);
    submitAnim->setDuration(400);
    submitAnim->setStartValue(1);
    submitAnim->setEndValue(0);

    auto compsGroup = new QParallelAnimationGroup(this);
    compsGroup->addAnimation(loginAnim);
    compsGroup->addAnimation(passwordAnim);
    compsGroup->addAnimation(submitAnim);
    compsGroup->start();

    // little trick cause there are many drawing artefacts if use QSequentialAnimationGroup
    connect(compsGroup, &QParallelAnimationGroup::finished, this, [this]()
    {
        ui->loginLineEdit->setVisible(false);
        ui->passwordLineEdit->setVisible(false);
        ui->submitButton->setVisible(false);

        auto frameOpacity = new QGraphicsOpacityEffect(ui->frame);
        ui->frame->setGraphicsEffect(frameOpacity);

        auto frameAnim = new QPropertyAnimation(frameOpacity, "opacity", this);
        frameAnim->setDuration(600);
        frameAnim->setStartValue(1);
        frameAnim->setEndValue(0);
        frameAnim->start();
    });
}

QVariant MainWindow::paletteInterpolator(QPalette const& start, QPalette const& end, qreal progress)
{
    auto startColor = start.color(QPalette::Text);
    auto endColor = end.color(QPalette::Text);
    auto target = QColor::fromRgb(
                        endColor.red()   * progress + startColor.red()   * (1-progress),
                        endColor.green() * progress + startColor.green() * (1-progress),
                        endColor.blue()  * progress + startColor.blue()  * (1-progress));
    auto palette = start;
    palette.setColor(QPalette::Text, target);

    /*
     * another algorithm for changing color
     *
    int startHue = startColor.hsvHue();
    int endHue = endColor.hsvHue();
    int startSat = startColor.hsvSaturation();
    int endSat = endColor.hsvSaturation();
    int startVal = startColor.value();
    int endVal = endColor.value();
    int deltaHue = qAbs(startHue - endHue);
    int deltaSat = qAbs(startSat - endSat);
    int deltaVal = qAbs(startVal - endVal);
    int dirHue = startHue > endHue ? -1 : 1;
    int dirSat = startSat > endSat ? -1 : 1;
    int dirVal = startVal > endVal ? -1 : 1;

    auto palette = start;
    palette.setColor(QPalette::Text, QColor::fromHsv(startHue + dirHue * progress * deltaHue,
                                                     startSat + dirSat * progress * deltaSat,
                                                     startVal + dirVal * progress * deltaVal));
    */
    return palette;
}

