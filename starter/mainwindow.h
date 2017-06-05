#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "wsserver.h"
#include <QStringList>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow(QWidget *parent = 0);
	~MainWindow();

private slots:
	void on_startButton_clicked();

	void on_stopButton_clicked();

	void on_seekButton_clicked();
	void setClientCount(int count);

private:
	Ui::MainWindow *ui;
	WsServer * wsServer;
	int  bookmarks[31] = { 6140, 23200, 145260, 198240, 230010, 309080,437280,509040,523280,551030, 600110,786090, 798180, 813200, 1009250, 1019000, 1033270, 1054270, 1127080, 1284170, 1322020,      1553170, 1750280, 1921120, 2006060, 2011230,         2016160, 2040140, 2062090, 2112180 };
	QStringList labels; // ["huomio","A","B","B2","C","D","D2","E","E2","F", "Y","G?","G2","H","H2","I","I2","J47","J101","K","K2",     "L2","N", "O", "P", "O2", "P2","Q","Q2","R" ]

};

#endif // MAINWINDOW_H
